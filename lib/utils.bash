#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/vektra/mockery"
TOOL_NAME="mockery"
TOOL_TEST="mockery --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

get_platform() {
	case "$(uname -s)" in
	Darwin) echo "Darwin" ;;
	Linux) echo "Linux" ;;
	*) fail "Unsupported platform: $(uname -s)" ;;
	esac
}

get_arch() {
	case "$(uname -m)" in
	x86_64 | amd64) echo "x86_64" ;;
	arm64 | aarch64) echo "arm64" ;;
	*) fail "Unsupported architecture: $(uname -m)" ;;
	esac
}

sha256() {
	if command -v sha256sum >/dev/null; then
		sha256sum "$1" | cut -d' ' -f1
	else
		shasum -a 256 "$1" | cut -d' ' -f1
	fi
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename asset url
	version="$1"
	filename="$2"
	asset="${TOOL_NAME}_${version}_$(get_platform)_$(get_arch).tar.gz"
	url="$GH_REPO/releases/download/v${version}/${asset}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"

	verify_checksum "$version" "$asset" "$filename"
}

verify_checksum() {
	local version asset filename checksums_url expected actual
	version="$1"
	asset="$2"
	filename="$3"
	checksums_url="$GH_REPO/releases/download/v${version}/checksum.txt"

	echo "* Verifying checksum..."
	expected="$(curl "${curl_opts[@]}" "$checksums_url" | grep " ${asset}\$" | cut -d' ' -f1)" ||
		fail "Could not fetch checksum from $checksums_url"
	actual="$(sha256 "$filename")"

	if [ -z "$expected" ] || [ "$expected" != "$actual" ]; then
		rm -f "$filename"
		fail "Checksum mismatch for $asset (expected: ${expected:-none}, actual: $actual)"
	fi
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

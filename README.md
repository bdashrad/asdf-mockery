<div align="center">

# asdf-mockery [![Build](https://github.com/bdashrad/asdf-mockery/actions/workflows/build.yml/badge.svg)](https://github.com/bdashrad/asdf-mockery/actions/workflows/build.yml) [![Lint](https://github.com/bdashrad/asdf-mockery/actions/workflows/lint.yml/badge.svg)](https://github.com/bdashrad/asdf-mockery/actions/workflows/lint.yml)

[mockery](https://vektra.github.io/mockery/latest/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Older releases on Apple Silicon](#older-releases-on-apple-silicon)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `sha256sum` or `shasum`, used to verify downloads.
- `GITHUB_API_TOKEN` (optional): set to avoid GitHub API rate limits.

# Install

Plugin:

```shell
asdf plugin add mockery
# or
asdf plugin add mockery https://github.com/bdashrad/asdf-mockery.git
```

mockery:

```shell
# Show all installable versions
asdf list-all mockery

# Install specific version
asdf install mockery latest

# Set a version globally (on your ~/.tool-versions file)
asdf global mockery latest

# Now mockery commands are available
mockery --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Older releases on Apple Silicon

The plugin downloads the release asset matching your OS and architecture. mockery did not publish `Darwin_arm64` builds for v2.7.4 and earlier, nor for v2.9.0, so installing those on Apple Silicon fails at download. Some tags (for example v2.9.1) have no GitHub release at all.

If you need one of these, the `Darwin_x86_64` build runs under [Rosetta 2](https://support.apple.com/en-us/102527) (`softwareupdate --install-rosetta`). This plugin does not fall back automatically, so download and unpack the x86_64 tarball from the [releases page](https://github.com/vektra/mockery/releases) manually, or use a newer release.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/bdashrad/asdf-mockery/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Bradford Clark](https://github.com/bdashrad/)

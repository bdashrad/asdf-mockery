# Contributing

## Prerequisites

- [asdf](https://asdf-vm.com)
- `bash`, `curl`, `git`, `tar`, and `sha256sum` or `shasum`
- [shellcheck](https://github.com/koalaman/shellcheck) and [shfmt](https://github.com/mvdan/sh), at the versions pinned in `.tool-versions`:

```shell
asdf plugin add shellcheck
asdf plugin add shfmt
asdf plugin add pre-commit
asdf install
```

## Pre-commit

Install the [pre-commit](https://pre-commit.com) hooks once per clone:

```shell
asdf install
pre-commit install
```

The same hooks run in CI on every pull request. To run them on all files:

```shell
pre-commit run --all-files
```

## Linting

```shell
scripts/lint.bash
scripts/format.bash # apply shfmt formatting
```

## Testing Locally

`asdf plugin test` clones the plugin from a git URL, so only committed changes are tested.

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# Test the plugin at the current working directory
asdf plugin test mockery "$PWD" "mockery --help"

# Test the published plugin
asdf plugin test mockery https://github.com/bdashrad/asdf-mockery.git "mockery --help"

# Test a specific mockery version
asdf plugin test mockery "$PWD" --asdf-tool-version 3.8.1 "mockery version"
```

Tests are automatically run in GitHub Actions on push and PR.

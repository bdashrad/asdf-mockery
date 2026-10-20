<div align="center">

# asdf-mockery [![Build](https://github.com/bdashrad/asdf-mockery/actions/workflows/build.yml/badge.svg)](https://github.com/bdashrad/asdf-mockery/actions/workflows/build.yml) [![Lint](https://github.com/bdashrad/asdf-mockery/actions/workflows/lint.yml/badge.svg)](https://github.com/bdashrad/asdf-mockery/actions/workflows/lint.yml)

[mockery](https://vektra.github.io/mockery/latest/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

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

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/bdashrad/asdf-mockery/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Bradford Clark](https://github.com/bdashrad/)

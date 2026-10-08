# Set up devenv

GitHub Action that installs [Nix](https://nixos.org) and [devenv](https://devenv.sh),
pulls from the devenv binary cache, and builds the project's devenv shell.

## Usage

```yaml
steps:
  - uses: actions/checkout@v7

  - uses: sagikazarmark/setup-devenv@v1

  - run: devenv test
```

The action builds the shell of the project in the working directory, so check out the repository first.

### Pin a devenv version

devenv comes from nixpkgs by default. Set `devenv-version` to install a release (or a branch, such as `main`) from the devenv flake instead:

```yaml
- uses: sagikazarmark/setup-devenv@v1
  with:
    devenv-version: "2.4.0"
```

### Use additional Cachix caches

```yaml
- uses: sagikazarmark/setup-devenv@v1
  with:
    cachix-caches: my-cache,another-cache
```

### Skip building the shell

Disable `build-shell` when the repository has no devenv configuration, or when you only need the `devenv` binary:

```yaml
- uses: sagikazarmark/setup-devenv@v1
  with:
    build-shell: false
```

## Inputs

| Name | Description | Default |
| --- | --- | --- |
| `devenv-version` | Version of devenv to install from its flake (for example `2.4.0` or `main`). Installs devenv from nixpkgs when empty. | `""` |
| `install-nix` | Install Nix. Disable it when the runner already has Nix. | `true` |
| `nix-config` | Gets appended to `/etc/nix/nix.conf` when Nix is installed. | `""` |
| `nix-install-url` | URL of the Nix installer script. | `""` |
| `nix-install-options` | Additional flags passed to the Nix installer script. | `""` |
| `github-access-token` | Token Nix uses to pull from GitHub. Defaults to the workflow token. | `""` |
| `cachix-caches` | Comma-separated list of additional Cachix caches to pull from, alongside the devenv cache. | `""` |
| `build-shell` | Build the devenv shell of the project in the working directory. | `true` |

## Releasing

Run the [Release](.github/workflows/release.yaml) workflow from the `main` branch and pick the part of the version to increment (`patch`, `minor` or `major`).
The workflow tags the commit, moves the major version tag (for example `v1`) to it and drafts a GitHub release.

GitHub has no API for listing a release on the Marketplace,
so finish the release by editing the draft, checking **Publish this Action to the GitHub Marketplace** and publishing it.

## License

The project is licensed under the [MIT License](LICENSE).

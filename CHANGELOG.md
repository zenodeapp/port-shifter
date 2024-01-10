
# Changelog

_Last updated on: 2024-01-10_ (YYYY-MM-DD)
 
## v1.0.0 - 2024-01-10

First release of the **Port Shifter**. This version has mostly been tested with Evmos' and Cronos' config files up till **Cosmos SDK v0.46.15**. The configurations were general enough to conclude that this tool can be use in most Tendermint or CometBFT-based consensus protocols.

### Added
- [quick-shift.sh](quick-shift.sh); script that allows the user to increment the ports in the `app.toml` and `config.toml` files **based on default port settings**.
- [shift-wizard.sh](shift-wizard.sh); a more advanced script that allows users to either individually customize each port in the `app.toml` and `config.toml` file or increment them all at once **based on default port settings**.
- [README.md](README.md); explains how to use this tool and describes the logic of the replacement commands.
- [Examples](/examples); configuration files to play around with. These are generating using the [**Cronos v1.0.15**](https://github.com/crypto-org-chain/cronos/releases/tag/v1.0.15) binary.
- [.gitignore](.gitignore); to ignore generated _.toml.bak_-files inside of the repository.
- [MIT License](LICENSE); to allow others to freely incorporate this tool into their own creative endeavors :).

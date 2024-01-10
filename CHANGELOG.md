
# Changelog

## v1.0.0 - 2024-01-10

First release of the **Port Shifter**. This version has mostly been tested with Evmos' and Cronos' config files up till **Cosmos SDK v0.46.15**. The configurations were general enough to conclude that this tool can be use in most Tendermint or CometBFT-based consensus protocols.

### Added
- [quick-shift.sh](quick-shift.sh); script that allows the user to increment the ports in the `app.toml` and `config.toml` files **based on default port settings**.
- [shift-wizard.sh](shift-wizard.sh); a more advanced script that allows users to either individually customize each port in the `app.toml` and `config.toml` file or increment them all at once **based on default port settings**.
- [README.md](README.md); explains how to use this tool, contains the current list of supported ports and describes the logic for the replacement commands.
- [Examples](/examples); configuration files to play around with. These are generating using the [**Cronos v1.0.15**](https://github.com/crypto-org-chain/cronos/releases/tag/v1.0.15) binary.
- [.gitignore](.gitignore); to ignore generated _.toml.bak_-files inside of the repository.
- [MIT License](LICENSE); to allow others to freely incorporate this tool into their own creative endeavors :).

### Sup<i>port</i>
- proxy_app (default: 26658)
- [rpc] laddr (default: 26657)
- pprof_laddr (default: 6060)
- [p2p] laddr (default: 26656)
- prometheus_listen_addr (default: 26660)
- [api] address (default: 1317)
- [rosetta] address (default: 8080)
- [grpc] address (default: 9090)
- [grpc-web] address (default: 9091)
- [json-rpc] address (default: 8545)
- [json-rpc] ws-address (default: 8546)
- [json-rpc] metrics-address (default: 6065)

<hr>

<p align="right">— ZEN</p>
<p align="right">Copyright (c) 2024 ZENODE</p>
<p align="right">Last updated on: <i>2024-01-10 (YYYY-MM-DD)</i></p>

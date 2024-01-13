# Port Shifter

A port replacer (or resetter) for the configuration files used in Tendermint or CometBFT-based protocols.

This has been written by ZENODE and is licensed under the MIT-license (see [LICENSE.md](./LICENSE.md)).

## Overview

It can get quite time-consuming to replace the ports inside of the `app.toml`, `config.toml` and `client.toml` files if you plan on running multiple nodes. This small repository aims to solve this problem by providing two scripts; both having the same purpose of simplifying the process of replacing the port values.

### 1. [shift-wizard.sh](shift-wizard.sh)

This wizard can either increment all ports by a common value _or_ let the user customize each port individually. It will start by asking whether you'd like to customize each port individually or not and continue from there.

This script can be run using:

```
sh shift-wizard.sh <path_to_config_dir>
```
> <path_to_config_dir> can either be an absolute or relative path towards the directory containing the `app.toml`, `config.toml` and `client.toml` files.

> [!TIP]
> If you made a mess of all your ports, then you can **reset the ports to their default values** by giving it an **increment** of **0**.

### 2. [quick-shift.sh](quick-shift.sh)

If you're in a limited or restrictive environment or do not trust running "complex" scripts then use this one instead. It is only capable of incrementing all port values, but can also be edited if one desires to edit every port individually by just changing the values for every port variable inside of the file and keeping the increment value at 0.

This script can be run using:

```
sh quick-shift.sh <path_to_config_dir> [port_increment_value]
```
> _[port_increment_value]_ is optional and defaults to 0, which will reset all the ports to their default values.

## Sup<i>port</i>

Here follows a list of all the ports that are currently supported, with their _default_ values:

```
# config.toml
proxy_app                    = 26658
[rpc] laddr                  = 26657
pprof_laddr                  = 6060
[p2p] laddr                  = 26656
prometheus_listen_addr       = 26660

# app.toml
[api] address                = 1317
[rosetta] address            = 8080
[grpc] address               = 9090
[grpc-web] address           = 9091
[json-rpc] address           = 8545
[json-rpc] ws-address        = 8546
[json-rpc] metrics-address   = 6065
```

## Logic

### for port replacement

> [!IMPORTANT]
> These scripts make a backup of the _.toml_ files (as _.toml.bak_ files), but do not take in account what ports were already configured _when incrementing_. Therefore the new ports get calculated **using the default port values stated in the script itself** and **not** what you _already_ had configured.

The logic for the _sed_-commands is to always look for the last colon (:). That way we only replace the _:port_ part, without having to worry about overwriting pre-configured ip-addresses that use _localhost_, _IPv4_ or _IPv6_ formatted addresses or protocols like _https://_ and _tcp://_.

### for identical keys
The lines that have the same _key name_ are separated from one another by checking under which section they belong (for instance the key _address_ gets used multiple times in e.g. _[api]_, _[grpc]_ and _[rosetta]_).

</br>

<p align="right">— ZEN</p>
<p align="right">Copyright (c) 2024 ZENODE</p>

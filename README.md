# port-shifter
A port replacer for app.toml and config.toml files, used in Tendermint or CometBFT-based protocols.

LOGIC
The logic for each sed is to always look for the last (:).
That way we only replace the part where the port is stated
and we don't have to take in account if an ip, localhost or
protocol is given.

# PORT SHIFTER for app.toml and config.toml files.
# https://github.com/zenodeapp/port-shifter
# ZENODE (https://zenode.app)

# This is a simplified version of the shifter, for those who
# are not fond of running (foreign) scripts. It's only capable
# of incrementing the ports by a common value, but can be edi-
# ted for individual port adjustment.

# Check if the correct number of arguments is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <path_to_config_files> [port_increment_value]"
    echo "  [port_increment_value] is optional (default: 0, which will reset ports to default)"
    echo ""
    exit 1
fi

# Provided arguments ($1 and $2)
CONFIG_PATH=$(eval echo "$1" | sed 's/\/$//') # expand tilde and remove trailing slash
INCREMENT=${2:-0} # 0 is default which will use the default ports stated below.

# Config.toml default ports
PROXY_APP=26658
RPC_LADDR=26657
PPROF_LADDR=6060
P2P_LADDR=26656
PROMETHEUS_LISTEN_ADDR=26660
ORACLE_RPC_ENDPOINT=8545

# Create a backup
cp $CONFIG_PATH/config.toml $CONFIG_PATH/config.toml.bak

# Shift ports
sed -i "/^proxy_app/ s/\(proxy_app = \".*\):\([0-9]*\)/\1:$((PROXY_APP + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[ledger.cometbft.rpc\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((RPC_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^pprof_laddr/ s/\(pprof_laddr = \".*\):\([0-9]*\)/\1:$((PPROF_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[ledger.cometbft.p2p\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((P2P_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^prometheus_listen_addr/ s/\(prometheus_listen_addr = \".*\):\([0-9]*\)/\1:$((PROMETHEUS_LISTEN_ADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^oracle_rpc_endpoint/ s/\(oracle_rpc_endpoint = \".*\):\([0-9]*\)/\1:$((ORACLE_RPC_ENDPOINT + INCREMENT))/" $CONFIG_PATH/config.toml
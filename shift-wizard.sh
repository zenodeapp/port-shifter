
# PORT SHIFTER for Namada-based config.toml file scheme.
# https://github.com/zenodeapp/port-shifter
# ZENODE (https://zenode.app)

# This wizard can either increment all ports by a common value or 
# let the user customize each port individually. If you do not trust
# this wizard or prefer a simpler variant, use quick-shift.sh instead.

read -p "What's the path to the main config.toml file? (example: ~/.local/share/namada/public-testnet-15.0dacadb8d663): " CONFIG_PATH
CONFIG_PATH=$(eval echo "$CONFIG_PATH" | sed 's/\/$//') # expand tilde and remove trailing slash

# Check if CONFIG_PATH is empty
if [ -z "$CONFIG_PATH" ]; then
    echo "Error: The path to the config file cannot be empty."
    exit 1
fi

# Check if config file exist
if [ ! -f "$CONFIG_PATH/config.toml" ]; then
    echo "Error: config file $CONFIG_PATH/config.toml not found."
    exit 1
fi

read -p "Do you want to customize each port individually? (y/N): " CUSTOM
CUSTOM=$(echo "$CUSTOM" | tr 'A-Z' 'a-z')  # Convert to lowercase

if [ "$CUSTOM" != "y" ]; then
    read -p "Enter the increment value for all ports: " INCREMENT

    # Check if common_increment is a number using grep
    if echo "$INCREMENT" | grep -q "^[0-9]\+$" && [ "$INCREMENT" -ne 0 ]; then
        echo "Incrementing all ports by $INCREMENT..."
    else
        INCREMENT=0
        echo "Resetting all ports to default values..."
    fi
fi

echo ""

# Helper function to prompt for port value
prompt_for_port() {
    local PORT_NAME="$1"
    local DEFAULT_VALUE="$2"

    read -p "Enter value for $PORT_NAME (default: $DEFAULT_VALUE): " USER_INPUT
    echo "${USER_INPUT:-$DEFAULT_VALUE}"
}

# backup
cp $CONFIG_PATH/config.toml $CONFIG_PATH/config.toml.bak

# Config.toml default ports
PROXY_APP=26658
RPC_LADDR=26657
PPROF_LADDR=6060
P2P_LADDR=26656
PROMETHEUS_LISTEN_ADDR=26660
ORACLE_RPC_ENDPOINT=8545

# Ask for each port value if CUSTOM is "y"
if [ "$CUSTOM" = "y" ]; then
    PROXY_APP=$(prompt_for_port "proxy_app" $PROXY_APP)
    RPC_LADDR=$(prompt_for_port "[rpc] laddr" $RPC_LADDR)
    PPROF_LADDR=$(prompt_for_port "pprof_laddr" $PPROF_LADDR)
    P2P_LADDR=$(prompt_for_port "[p2p] laddr" $P2P_LADDR)
    PROMETHEUS_LISTEN_ADDR=$(prompt_for_port "prometheus_listen_addr" $PROMETHEUS_LISTEN_ADDR)
    ORACLE_RPC_ENDPOINT=$(prompt_for_port "oracle_rpc_endpoint" $ORACLE_RPC_ENDPOINT)
fi

sed -i "/^proxy_app/ s/\(proxy_app = \".*\):\([0-9]*\)/\1:$((PROXY_APP + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[ledger.cometbft.rpc\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((RPC_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^pprof_laddr/ s/\(pprof_laddr = \".*\):\([0-9]*\)/\1:$((PPROF_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[ledger.cometbft.p2p\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((P2P_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^prometheus_listen_addr/ s/\(prometheus_listen_addr = \".*\):\([0-9]*\)/\1:$((PROMETHEUS_LISTEN_ADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^oracle_rpc_endpoint/ s/\(oracle_rpc_endpoint = \".*\):\([0-9]*\)/\1:$((ORACLE_RPC_ENDPOINT + INCREMENT))/" $CONFIG_PATH/config.toml

echo "Ports have been replaced in $CONFIG_PATH/config.toml"

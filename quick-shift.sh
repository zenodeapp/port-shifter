
# PORT SHIFTER for app.toml and config.toml files.
# https://github.com/zenodeapp/port-shifter
# ZENODE (https://zenode.app)

# This is a simplified version of the shifter, for those who
# are not fond of running (foreign) scripts. It's only capable
# of incrementing the ports by a common factor, but can be edi-
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

# App.toml default ports
API_ADDRESS=1317
ROSETTA_ADDRESS=8080
GRPC_ADDRESS=9090
GRPC_WEB_ADDRESS=9091
JSON_RPC_ADDRESS=8545
JSON_RPC_WS_ADDRESS=8546
JSON_RPC_METRICS_ADDRESS=6065

# Create a backup
cp $CONFIG_PATH/config.toml $CONFIG_PATH/config.toml.bak
cp $CONFIG_PATH/app.toml $CONFIG_PATH/app.toml.bak

# Shift ports
sed -i "/^proxy_app/ s/\(proxy_app = \".*\):\([0-9]*\)/\1:$((PROXY_APP + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[rpc\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((RPC_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^pprof_laddr/ s/\(pprof_laddr = \".*\):\([0-9]*\)/\1:$((PPROF_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[p2p\]/,/\[.*\]/ s/\(laddr = \".*\):\([0-9]*\)/\1:$((P2P_LADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^prometheus_listen_addr/ s/\(prometheus_listen_addr = \".*\):\([0-9]*\)/\1:$((PROMETHEUS_LISTEN_ADDR + INCREMENT))/" $CONFIG_PATH/config.toml
sed -i "/^\[api\]/,/\[.*\]/ s/\(address = \".*\):\([0-9]*\)/\1:$((API_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
sed -i "/^\[rosetta\]/,/\[.*\]/ s/\(address = \".*\):\([0-9]*\)/\1:$((ROSETTA_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
sed -i "/^\[grpc\]/,/\[.*\]/ s/\(address = \".*\):\([0-9]*\)/\1:$((GRPC_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
sed -i "/^\[grpc-web\]/,/\[.*\]/ s/\(address = \".*\):\([0-9]*\)/\1:$((GRPC_WEB_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
# Make sure to run the three below together and do not comment out the last two, since the first will at first overwrite all three.
sed -i "/^\[json-rpc\]/,/\[.*\]/ s/\(address = \".*\):\([0-9]*\)/\1:$((JSON_RPC_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
sed -i "/^\[json-rpc\]/,/\[.*\]/ s/\(ws-address = \".*\):\([0-9]*\)/\1:$((JSON_RPC_WS_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
sed -i "/^\[json-rpc\]/,/\[.*\]/ s/\(metrics-address = \".*\):\([0-9]*\)/\1:$((JSON_RPC_METRICS_ADDRESS + INCREMENT))/" $CONFIG_PATH/app.toml
echo "BeamMP Installer"

if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

echo "";
echo "Server name from KeyMaster: ";
read server_name;
echo "Auth key from KeyMaster";
read auth_key;
echo "Description: ";
read description;
echo "";

REPO_URL="https://raw.githubusercontent.com/ignkuto/beammp-installer/main/"

mkdir BeamMP_Server && cd BeamMP_Server
wget https://www.beammp.com/server/BeamMP_Server.zip
sudo apt-get install unzip
unzip ./BeamMP_Server.zip
rm -r BeamMP-Server.exe
rm -r zip.zip

echo "Installing Dependencies"
sudo apt-get install libz-dev
sudo apt-get install rapidjson-dev
sudo apt-get install liblua5.3
sudo apt-get install libssl-dev
sudo apt-get install libwebsocketpp-dev
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install git
sudo apt-get install make
sudo apt-get install cmake
sudo apt-get install g++
echo "Installed Dependencies"

echo "Editing config file"
#rm -r ./ServerConfig.toml
cat << EOF > BeamMP_Server/ServerConfig.toml
[General]
AuthKey = '${auth_key}'
Debug = false
Description = '${description}'
Map = '/levels/gridmap_v2/info.json'
MaxCars = 1
MaxPlayers = 10
Name = '${server_name}'
Port = 30814
Private = true
ResourceFolder = 'Resources'
EOF
echo "Edited config file"

chmod +x ./BeamMP-Server-linux
echo "+x permission given to 'BeamMP-Server-linux'"

#echo "Launching server"
#echo "Press CTRL-C after 'Authenticated'!"
#echo "Press CTRL-C after 'Authenticated'!"
#echo "Press CTRL-C after 'Authenticated'!"
#chmod +x ./BeamMP-Server-linux
#sudo ./BeamMP-Server-linux & PID=$! & kill -INT -$PID
#echo "Server stopped"

PUBLIC_IP="$(cut -d ' ' -f 1 <<< "$(hostname -I)")"
echo ""
echo "Server installed!"
echo "Public IP: ${PUBLIC_IP}"
echo "Server Name: ${server_name}"
echo "Port: 30814"
echo "Private Server: true"
echo "Map: gridmap_v2"
echo ""
echo "You can always change the settings in ServerConfig.toml"
echo "Launch the server by running:"
echo "cd BeamMP_Server && sudo ./BeamMP*"

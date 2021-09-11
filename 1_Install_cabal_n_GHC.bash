#this starter is for install node & cli

#### Minimum Stake Pool Hardware Requirements ####

#Two separate servers: 1 for block producer node, 1 for relay node
#One air-gapped offline machine (cold environment)
#Operating system: 64-bit Linux (i.e. Ubuntu Server 20.04 LTS)
#Processor: An Intel or AMD x86 processor with two or more cores, at 2GHz or faster
#Memory: 8GB of RAM
#Storage: 50GB of free storage
#Internet: Broadband internet connection with speeds at least 10 Mbps.
#Data Plan: at least 1GB per hour. 720GB per month.
#Power: Reliable electrical power
#ADA balance: at least 505 ADA for pool deposit and transaction fees


#### Recommended Future-proof Stake Pool Hardware Setup####

#Three separate servers: 1 for block producer node, 2 for relay nodes
#One air-gapped offline machine (cold environment)
#Operating system: 64-bit Linux (i.e. Ubuntu 20.04 LTS)
#Processor: 4 core or higher CPU
#Memory: 8GB+ of RAM
#Storage: 256GB+ SSD
#Internet: Broadband internet connections with speeds at least 100 Mbps
#Data Plan: Unlimited
#Power: Reliable electrical power with UPS
#ADA balance: more pledge is better, to be determined by a0, the pledge influence factor






#### 1. Install Cabal and GHC ####

#If using Ubuntu Desktop, press Ctrl+Alt+T. This will launch a terminal window. 
#First, update packages and install Ubuntu dependencies.


sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install git jq bc make automake rsync htop curl build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ wget libncursesw5 libtool autoconf -y

# Install Libsodium.

mkdir $HOME/git
cd $HOME/git
git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

#Debian OS pool operators: extra lib linking may be required.
#sudo ln -s /usr/local/lib/libsodium.so.23.3.0 /usr/lib/libsodium.so.23


#AWS Linux CentOS pool operators: clearing the lib cache may be required.
sudo ldconfig


#Raspberry Pi 4 with Ubuntu pool operators : extra lib linking may be required.
#sudo apt-get install libnuma-dev

# ⬆️ This will help to solve "cannot find -lnuma" error when compiling

#Install Cabal and dependencies.

sudo apt-get -y install pkg-config libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev build-essential curl libgmp-dev libffi-dev libncurses-dev libtinfo5

echo "Answer NO to installing haskell-language-server (HLS)."
echo "Answer YES to automatically add the required PATH variable to '.bashrc'."

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

cd $HOME
source .bashrc
ghcup upgrade
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

#Install GHC.

ghcup install ghc 8.10.4
ghcup set ghc 8.10.4

#Update PATH to include Cabal and GHC and add exports. Your node's location will be in $NODE_HOME. The cluster configuration is set by $NODE_CONFIG and $NODE_BUILD_NUM. 

echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc
echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo export NODE_HOME=$HOME/cardano-my-node >> $HOME/.bashrc
echo export NODE_CONFIG=mainnet>> $HOME/.bashrc
echo export NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> $HOME/.bashrc
source $HOME/.bashrc

#💡 How to use this Guide on TestNet

#Run the following commands to set your NODE_CONFIG to testnet rather than mainnet.

#echo export NODE_CONFIG=testnet>> $HOME/.bashrc
#source $HOME/.bashrc
#As you work through this guide, replace every instance of CLI parameter

# --mainnet
#with

#--testnet-magic 1097911063

#Update cabal and verify the correct versions were installed successfully.

cabal update
cabal --version
ghc --version

# Cabal library should be version 3.4.0.0 and GHC should be version 8.10.4



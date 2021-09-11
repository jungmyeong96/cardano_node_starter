####  5. Configure the relay node(s) ####

echo "Did you edit your ip in this bash file?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

# On your other server that will be designed as your relay node or what we will call relaynode1 throughout this guide, carefully repeat steps 1 through 3 in order to build the cardano binaries.

#You can have multiple relay nodes as you scale up your stake pool architecture. Simply create relaynodeN and adapt the guide instructions accordingly.


# On your relaynode1, run with the following after updating with your block producer's public IP address.


cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF 
 {
    "Producers": [
      {
        "addr": "<BLOCK PRODUCER NODE'S PUBLIC IP ADDRESS>",
        "port": 6000,
        "valency": 1
      },
      {
        "addr": "relays-new.cardano-mainnet.iohk.io",
        "port": 3001,
        "valency": 2
      }
    ]
  }
EOF


#Valency tells the node how many connections to keep open. Only DNS addresses are affected. If value is 0, the address is ignored.

# Port Forwarding Tip: You'll need to forward and open ports 6000 to your nodes. Check with https://www.yougetsignal.com/tools/open-ports/ or https://canyouseeme.org/ .




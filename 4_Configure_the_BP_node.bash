####  4. Configure the block-producer node ####

echo "before you do this work, check your ip for node!\n"

echo "Did you edit your ip in this bash file?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done


#A block producer node will be configured with various key-pairs needed for block generation (cold keys, KES hot keys and VRF hot keys). It can only connect to its relay nodes.

#A relay node will not be in possession of any keys and will therefore be unable to produce blocks. It will be connected to its block-producing node, other relays and external nodes.

#For the purposes of this guide, we will be building two nodes on two separate servers. One node will be designated the block producer node, and the other will be the relay node, named relaynode1

#Configure topology.json file so that 
#relay node(s) connect to public relay nodes (like IOHK and buddy relay nodes) and your block-producer node
#block-producer node only connects to your relay node(s)


# On your block-producer node, run the following. Update the addr with your relay node's public IP address.

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF
 {
    "Producers": [
      {
        "addr": "<RELAYNODE1'S PUBLIC IP ADDRESS>",
        "port": 6000,
        "valency": 1
      }
    ]
  }
EOF



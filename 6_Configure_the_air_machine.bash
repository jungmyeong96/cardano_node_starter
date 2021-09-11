#### Configure the air-gapped offline machine ####


#An air-gapped offline machine is called your cold environment. 

#- Protects against key-logging attacks, malware/virus based attacks and other firewall or security exploits. 
#- Physically isolated from the rest of your network. 
#- Must not have a network connection, wired or wireless. 
#- Is not a VM on a machine with a network connection.
#- Learn more about air-gapping at wikipedia.


echo export NODE_HOME=$HOME/cardano-my-node >> $HOME/.bashrc
source $HOME/.bashrc
mkdir -p $NODE_HOME

#Copy from your hot environment, also known as your block producer node, a copy of the cardano-cli binaries to your cold environment, this air-gapped offline machine. 

#In order to remain a true air-gapped environment, you must move files physically between your cold and hot environments with USB keys or other removable media.







#### 7. Create startup scripts ####


# The startup script contains all the variables needed to run a cardano-node such as directory, port, db path, config file, and topology file.

cat > $NODE_HOME/startBlockProducingNode.sh << EOF
#!/bin/bash
DIRECTORY=$NODE_HOME
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=\${DIRECTORY}/${NODE_CONFIG}-topology.json
DB_PATH=\${DIRECTORY}/db
SOCKET_PATH=\${DIRECTORY}/db/socket
CONFIG=\${DIRECTORY}/${NODE_CONFIG}-config.json
/usr/local/bin/cardano-node run --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
EOF

cat > $NODE_HOME/startRelayNode1.sh << EOF 
#!/bin/bash
DIRECTORY=$NODE_HOME
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=\${DIRECTORY}/${NODE_CONFIG}-topology.json
DB_PATH=\${DIRECTORY}/db
SOCKET_PATH=\${DIRECTORY}/db/socket
CONFIG=\${DIRECTORY}/${NODE_CONFIG}-config.json
/usr/local/bin/cardano-node run --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
EOF


#Add execute permissions to the startup script.#

chmod +x $NODE_HOME/startBlockProducingNode.sh

chmod +x $NODE_HOME/startRelayNode1.sh 

#Run the following to create a systemd unit file to define yourcardano-node.service configuration.

#Benefits of using systemd for your stake pool
#1.Auto-start your stake pool when the computer reboots due to maintenance, power outage, etc.
#2.Automatically restart crashed stake pool processes.
#3.Maximize your stake pool up-time and performance.

cat > $NODE_HOME/cardano-node.service << EOF
# The Cardano node service (part of systemd)
# file: /etc/systemd/system/cardano-node.service

[Unit]
Description     = Cardano node service
Wants           = network-online.target
After           = network-online.target

[Service]
User            = ${USER}
Type            = simple
WorkingDirectory= ${NODE_HOME}
ExecStart       = /bin/bash -c '${NODE_HOME}/startBlockProducingNode.sh'
KillSignal=SIGINT
RestartKillSignal=SIGINT
TimeoutStopSec=2
LimitNOFILE=32768
Restart=always
RestartSec=5
SyslogIdentifier=cardano-node

[Install]
WantedBy	= multi-user.target
EOF

cat > $NODE_HOME/cardano-node.service << EOF 
# The Cardano node service (part of systemd)
# file: /etc/systemd/system/cardano-node.service 

[Unit]
Description     = Cardano node service
Wants           = network-online.target
After           = network-online.target 

[Service]
User            = ${USER}
Type            = simple
WorkingDirectory= ${NODE_HOME}
ExecStart       = /bin/bash -c '${NODE_HOME}/startRelayNode1.sh'
KillSignal=SIGINT
RestartKillSignal=SIGINT
TimeoutStopSec=2
LimitNOFILE=32768
Restart=always
RestartSec=5
SyslogIdentifier=cardano-node

[Install]
WantedBy	= multi-user.target
EOF

#Move the unit file to /etc/systemd/system and give it permissions.

sudo mv $NODE_HOME/cardano-node.service /etc/systemd/system/cardano-node.service

sudo chmod 644 /etc/systemd/system/cardano-node.service

#Run the following to enable auto-starting of your stake pool at boot time.

sudo systemctl daemon-reload
sudo systemctl enable cardano-node

#Your stake pool is now managed by the reliability and robustness of systemd. Below are some commands for using systemd.


### node management commands ###

# View the status of the node service

# sudo systemctl status cardano-node

# Restarting the node service

#Stopping the node service

#sudo systemctl stop cardano-node

#Viewing and filter logs

#journalctl --unit=cardano-node --follow
#journalctl --unit=cardano-node --since=yesterday
#journalctl --unit=cardano-node --since=today
#journalctl --unit=cardano-node --since='2020-07-29 00:00:00' --until='2020-07-29 12:00:00'









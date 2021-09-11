#### 2. Build the node from source code ####

#Download source code and switch to the latest tag.

cd $HOME/git
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout $(curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r .tag_name)

#Configure build options.

cabal configure -O0 -w ghc-8.10.4

#Update the cabal config, project settings, and reset build folder.


echo -e "package cardano-crypto-praos\n flags: -external-libsodium-vrf" > cabal.project.local
sed -i $HOME/.cabal/config -e "s/overwrite-policy:/overwrite-policy: always/g"
rm -rf $HOME/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.4

#Build the cardano-node from source code.

cabal build cardano-cli cardano-node

#Copy cardano-cli and cardano-node files into bin directory.

sudo cp $(find $HOME/git/cardano-node/dist-newstyle/build -type f -name "cardano-cli") /usr/local/bin/cardano-cli

sudo cp $(find $HOME/git/cardano-node/dist-newstyle/build -type f -name "cardano-node") /usr/local/bin/cardano-node

#Verify your cardano-cli and cardano-node are the expected versions.

cardano-node version
cardano-cli version

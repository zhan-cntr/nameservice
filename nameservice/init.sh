#!/usr/bin/env bash

rm -rf ~/.centaurusd
rm -rf ~/.centauruscli

centaurusd init test --chain-id=namechain

centauruscli config output json
centauruscli config indent true
centauruscli config trust-node true
centauruscli config chain-id namechain
centauruscli config keyring-backend test

centauruscli keys add user1
centauruscli keys add user2

centaurusd add-genesis-account $(centauruscli keys show user1 -a) 1000nametoken,100000000stake
centaurusd add-genesis-account $(centauruscli keys show user2 -a) 1000nametoken,100000000stake

centaurusd gentx --name user1 --keyring-backend test

echo "Collecting genesis txs..."
centaurusd collect-gentxs

echo "Validating genesis file..."
centaurusd validate-genesis


centaurusd collect-gentxs
centaurusd validate-genesis
centaurusd start

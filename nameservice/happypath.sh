#!/bin/bash

centauruscli query account $(centauruscli keys show user1 -a) | jq ".value.coins[0]"
centauruscli query account $(centauruscli keys show user2 -a) | jq ".value.coins[0]"

# Buy your first name using your coins from the genesis file
centauruscli tx nameservice buy-name user1.id 5nametoken --from user1 -y | jq ".txhash" |  xargs $(sleep 6) centauruscli q tx

# Set the value for the name you just bought
centauruscli tx nameservice set-name user1.id 8.8.8.8 --from user1 -y | jq ".txhash" |  xargs $(sleep 6) centauruscli q tx

# Try out a resolve query against the name you registered
centauruscli query nameservice resolve user1.id | jq ".value"
# > 8.8.8.8

# Try out a whois query against the name you just registered
centauruscli query nameservice get-whois user1.id
# > {"value":"8.8.8.8","owner":"cosmos1l7k5tdt2qam0zecxrx78yuw447ga54dsmtpk2s","price":[{"denom":"nametoken","amount":"5"}]}

# Xane buys name from zhan-cntr
centauruscli tx nameservice buy-name user1.id 10nametoken --from user2 -y | jq ".txhash" |  xargs $(sleep 6) centauruscli q tx

# Xane decides to delete the name she just bought from zhan-cntr
centauruscli tx nameservice delete-name user1.id --from user2 -y | jq ".txhash" |  xargs $(sleep 6) centauruscli q tx

# Try out a whois query against the name you just deleted
centauruscli query nameservice get-whois user1.id
# > {"value":"","owner":"","price":[{"denom":"nametoken","amount":"1"}]}
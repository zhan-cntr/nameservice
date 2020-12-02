#!/bin/bash

nameservicecli query account $(nameservicecli keys show zhan-cntr -a) | jq ".value.coins[0]"
nameservicecli query account $(nameservicecli keys show Xane -a) | jq ".value.coins[0]"

# Buy your first name using your coins from the genesis file
nameservicecli tx nameservice buy-name zhan-cntr.id 5nametoken --from zhan-cntr -y | jq ".txhash" |  xargs $(sleep 6) nameservicecli q tx

# Set the value for the name you just bought
nameservicecli tx nameservice set-name zhan-cntr.id 8.8.8.8 --from zhan-cntr -y | jq ".txhash" |  xargs $(sleep 6) nameservicecli q tx

# Try out a resolve query against the name you registered
nameservicecli query nameservice resolve zhan-cntr.id | jq ".value"
# > 8.8.8.8

# Try out a whois query against the name you just registered
nameservicecli query nameservice get-whois zhan-cntr.id
# > {"value":"8.8.8.8","owner":"cosmos1l7k5tdt2qam0zecxrx78yuw447ga54dsmtpk2s","price":[{"denom":"nametoken","amount":"5"}]}

# Xane buys name from zhan-cntr
nameservicecli tx nameservice buy-name zhan-cntr.id 10nametoken --from Xane -y | jq ".txhash" |  xargs $(sleep 6) nameservicecli q tx

# Xane decides to delete the name she just bought from zhan-cntr
nameservicecli tx nameservice delete-name zhan-cntr.id --from Xane -y | jq ".txhash" |  xargs $(sleep 6) nameservicecli q tx

# Try out a whois query against the name you just deleted
nameservicecli query nameservice get-whois zhan-cntr.id
# > {"value":"","owner":"","price":[{"denom":"nametoken","amount":"1"}]}
#!/bin/bash

cd ~/.chia/mainnet/log


filters_passed=$(cat debug.log* | grep "[1-9] plots were eligible" | wc -l)
proofs=$(cat debug.log* | grep "Found [1-9] proofs" | wc -l)

echo "Found plots eligible for filter: $filters_passed"
echo "Found proofs: $proofs"

#! /bin/bash

set -euo pipefail

print_each() {
	for arg; do
		echo "${arg}"
	done
}

# create some directories with spaces in the names
mkdir -p ifs/"a b"/{"c d","e f"}/{"g h","i j"}

# Let's see what we did
find . -type d

# Let's keep the directory names in a variable
directories=$(find . -type d)

# Iterating over them is going to be trouble
print_each ${directories}

# This will fix it: remove space from IFS
IFS=$'\t\n'

# Let's try again
print_each ${directories}

# cleanup
rm -r ifs


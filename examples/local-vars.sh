#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail

my_fun() {
  var='Hello world!'
}

my_fun

echo "${var}"

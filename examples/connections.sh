#! /usr/bin/env bash
#
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Give a list of all open connections, consisting of IP address and host name
# (if reverse DNS lookup succeeds).
#
# https://github.com/bertvv/scripts/blob/master/src/connections.sh

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors in pipes
 
IFS=$'\t\n'          # Set Internal Field Separator
readonly debug='off'  # Enable debug mode when set to 'on'

main() {
  debug "Main loop"

  check_args "${@}"

  check_dependencies

  for ip in $(active_hosts); do
    print_host_info "${ip}"
  done
}

# {{{ Functions

# Argument checking
check_args() {
  debug "Checking arguments: ${@}"

  if [ "$#" -eq '0' ]; then
    debug "No arguments given"
    return 0
  fi

  debug "At least one argument given"

  if help_wanted "${1}"; then
    usage
    exit 0
  fi
}

help_wanted() {
  debug "Checking if help is wanted with arg: ${1}"

  [ "${1}" = '-h' ] || \
  [ "${1}" = '--help' ] || \
  [ "${1}" = '-?' ]
}

# Prints help message
usage() {
cat << _EOF_
Usage: ${0} [-h|--help|-?]
  Print a list of hosts with an open TCP connection, consisting of their IP
  address and host name (if a reverse DNS lookup succeeds).

  Any other command line arguments are ignored.
_EOF_
}

# Usage: check_dependencies
#   Checks whether the commands needed for this script exist
check_dependencies() {
  debug 'Checking dependencies'

  if ! which dig > /dev/null 2>&1; then
    error "The dig command is not available, install it first!"
    exit 1
  fi

  if ! which whois > /dev/null 2>&1; then
    error "The whois command is not available, install it first!"
    exit 1
  fi
  
}

# Usage: active_hosts
#   List all hosts with an active TCP connection
active_hosts() {
  debug "Listing hosts with an active TCP Connection"

  ss --tcp --numeric --ipv4 \
    | awk '/ESTAB/ {print $5}' \
    | strip_port \
    | sort -n \
    | uniq
}

# Usage: CMD | strip_port
#   Strips the port number from a string of the form IP_ADDRESS:PORT,
#   read from standard input
strip_port() {
  sed 's/:.*$//'
}

# Usage: print_host_info IP_ADDRESS
#   Print the specified IP address, and its associated network name and host
#   name (if available).
print_host_info() {
  local ip_address="${1}"

  debug "Printing host info for ${ip_address}"

  local host_name=$(reverse_lookup "${ip_address}")
  local net_name=$(network_name "${ip_address}")

  printf "%16s %20s %s\n"  "${ip_address}" "${net_name}" "${host_name}"
}

# Usage: reverse_lookup IP_ADDRESS
#   Perform a reverse DNS lookup, only returning the host name
reverse_lookup() {
  local ip_address="${1}"

  debug "Performing reverse lookup for ${ip_address}"

  dig -x "${ip_address}" +short \
    | head -1
}

# Usage: whois IP_ADDRESS
#   Use whois to find out the network name
network_name() {
  local ip_address="${1}"

  debug "Looking up network name for ${ip_address}"

  whois "${ip_address}" \
    | grep --ignore-case netname \
    | head -1 \
    | awk '{print $2}'
}

# Usage: debug "MESSAGE"
#   Print a debug message (in cyan), when debug mode is "on"
debug() {
  if [ "${debug}" = 'on' ]; then
    printf '\e[0;36m[DBG] %s\e[0m\n' "${*}" 1>&2
  fi
}

# Usage: error "MESSAGE"
#   Print an error message (in red)
error() {
  printf '\e[0;31m[ERR] %s\e[0m\n' "${*}" 1>&2
}

main "${@}"

#}}}
#! /usr/bin/env bash
#
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# Give a list of all open connections, consisting of IP address and host name
# (if reverse DNS lookup succeeds).
#
# Quick & dirty version

ips=`ss -tn4 | awk '/ESTAB/ {print $5}' | sed 's/:.*$//' | sort -n | uniq`

for ip in ${ips}; do
  name=`dig -x "${ip}" +short | head -1`
  net=`whois "${ip}" | grep -i | head -1 | awk '{print $2}'`
  
  printf "%16s %20s %s\n"  "${ip}" "${net}" "${name}"
done
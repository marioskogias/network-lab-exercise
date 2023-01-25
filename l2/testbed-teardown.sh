#!/bin/bash

set -xe

rm_bridge () {
  if ip link show $1 &> /dev/null; then
    ip link set dev $1 down
    brctl delbr $1
  fi
}

rm_pair () {
  if ip link show $1 &> /dev/null; then
    ip link delete $1 type veth
  fi
}

rm_ns () {
  if ip netns show $1 &> /dev/null; then
    ip netns delete $1
  fi
}

rm_bridge br0
rm_pair veth0
rm_pair veth2
rm_ns vm0

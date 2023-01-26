#!/bin/bash

set -xe

create_bridge () {
  if ! ip link show $1 &> /dev/null; then
    brctl addbr $1
    ip link set dev $1 up
  fi
}

create_pair () {
  if ! ip link show $1 &> /dev/null; then
    ip link add name $1 type veth peer name $2
    ip addr add $3 brd + dev $1
    brctl addif $4 $2
    ip link set dev $1 up
    ip link set dev $2 up
  fi
}

create_pair_ns () {
  if ! ip link show $1 &> /dev/null; then
    ip link add name $1 type veth peer name $2
    brctl addif $4 $2
    ip link set dev $2 up

    ip netns add $5
    ip link set $1 netns $5
    ip netns exec $5 ip addr add $3 brd + dev $1
    ip netns exec $5 ip link set dev $1 up
  fi
}

create_bridge br0
create_pair veth0 veth1 "10.1.0.1/24" br0
create_pair_ns veth2 veth3 "10.1.0.2/24" br0 vm0
create_pair_ns veth4 veth5 "10.1.0.3/24" br0 vm1

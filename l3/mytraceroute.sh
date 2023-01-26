#!/bin/bash

set -xe
sudo ip netns exec vm0 traceroute 10.1.0.2

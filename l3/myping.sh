#!/bin/bash

set -xe
sudo ip netns exec vm0 ping 10.1.0.2

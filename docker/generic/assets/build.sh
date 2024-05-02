#!/usr/bin/env bash

set -euo pipefail

SCRIPTPATH=$( dirname "$(realpath "$0")" )

apt update

# install packages
apt install -y kmod linux-perf strace bpftrace bcc bpfcc-tools systemtap-sdt-dev

# install FlameGraph
curl -fsSL https://github.com/brendangregg/FlameGraph/archive/refs/heads/master.tar.gz > "${SCRIPTPATH}/FlameGraph.tar.gz"
tar zxf "${SCRIPTPATH}/FlameGraph.tar.gz" -C /opt
mv /opt/FlameGraph-master /opt/FlameGraph

# install py-spy
apt install -y python3-pip
pip install py-spy==0.3.14 --break-system-packages --index-url=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/

# create workspace
mkdir -p /opt/workspace

# clean
apt-get clean
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/cron.daily/*

#!/bin/bash
cd /usr/local
/bin/tar -zxf /go.tar.gz
/bin/tar -zxf /node.tar.gz
ln -s node-v10.20.1-linux-x64/ node
/bin/echo 'PATH=$PATH:/usr/local/node/bin' >> /etc/bash.bashrc
/bin/echo 'PATH=$PATH:/usr/local/go/bin' >> /etc/bash.bashrc



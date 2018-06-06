FROM ubuntu:xenial-20180417

# apt-get stuff we need
RUN apt-get update; apt-get --assume-yes install python-pip python3-pip python3-openssl python-dev libssl-dev libre2-dev sudo zookeeper zookeeperd git-core python3-urllib3

# add users we want
RUN addgroup --system zuul \
    && adduser --system --ingroup zuul --home /var/lib/zuul --disabled-password zuul
RUN addgroup --system nodepool \
    && adduser --system --ingroup nodepool --home /var/lib/nodepool --disabled-password nodepool

# sudo for users
RUN echo "zuul ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/zuul
RUN echo "nodepool ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/nodepool

# as nodepool
USER nodepool
RUN pip3 install --user cffi
RUN pip3 install --user pbr
RUN pip3 install --user nodepool

# as zuul
USER zuul
RUN pip3 install --user cffi
RUN pip3 install --user zuul

# back to root
USER root

# ports
EXPOSE 9000
EXPOSE 8005
EXPOSE 2181
EXPOSE 7900

# make dirs for configs, etc.
RUN mkdir -p /etc/zuul; chown zuul.zuul /etc/zuul
RUN mkdir -p /var/log/zuul; chown zuul.zuul /var/log/zuul; chmod 775 /var/log/zuul
RUN mkdir -p /var/run/zuul; chown zuul.zuul /var/run/zuul; chmod 775 /var/run/zuul
RUN mkdir -p /etc/nodepool; chown nodepool.nodepool /etc/nodepool
RUN mkdir -p /var/log/nodepool; chown nodepool.nodepool /var/log/nodepool; chmod 775 /var/log/nodepool
RUN mkdir -p /var/run/nodepool; chown nodepool.nodepool /var/run/nodepool; chmod 775 /var/run/nodepool

# Copy configs from host
ENV src=./config

# chown not supported till later versions of docker, have to make this seperate commands
ADD ${src}/zuul.tar.gz /
RUN chown zuul.zuul -R /etc/zuul /var/lib/zuul

ADD ${src}/nodepool.tar.gz /
RUN chown nodepool.nodepool -R /etc/nodepool /var/lib/nodepool

USER zuul

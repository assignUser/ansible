FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

ARG TAGS=gh
RUN addgroup --gid 1000 jwj
RUN adduser --gecos jwj --uid 1000 --gid 1000 --disabled-password jwj && \
    echo "jwj ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER jwj
CMD ["sh", "-c", "cd /ansible && ansible-playbook $TAGS main.yml"]

FROM ubuntu:16.04

# tools
RUN apt-get update && \
	apt-get install -y software-properties-common git curl rsync gettext-base && \
	apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["bash"]


# bats
ENV BATS_VERSION 0.4.0
RUN apt-get update && \
 	apt-get install -y bats=${BATS_VERSION}-1ubuntu4 netcat && \
	apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# ansible
ENV ANSIBLE_VERSION 2.2.0.0

RUN apt-add-repository ppa:ansible/ansible && \
	apt-get update && \
	apt-get install -y ansible=${ANSIBLE_VERSION}-1ppa~xenial python-pip rsync && \
	apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# digitial ocean in newest version is broken
RUN pip install 'dopy==0.3.5'

# ansible lint
RUN pip install ansible-lint==3.4.4


# kubectl
ENV KUBECTL_VERSION v1.5.1

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl

# cfssl
RUN curl -L https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /usr/local/bin/cfssl \
 && chmod +x /usr/local/bin/cfssl \
 && curl -L https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /usr/local/bin/cfssljson \
 && chmod +x /usr/local/bin/cfssljson

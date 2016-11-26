FROM ubuntu:16.04

# tools
RUN apt-get update && \
	apt-get install -y software-properties-common git curl rsync && \
	rm -rf /var/lib/apt/lists/*
CMD ["bash"]


# bats
ENV BATS_VERSION 0.4.0
RUN apt-get update && \
 	apt-get install -y bats=${BATS_VERSION}-1ubuntu4 netcat && \
 	rm -rf /var/lib/apt/lists/*


# ansible
ENV ANSIBLE_VERSION 2.2.0.0

RUN apt-add-repository ppa:ansible/ansible && \
	apt-get update && \
	apt-get install -y ansible=${ANSIBLE_VERSION}-1ppa~xenial python-pip rsync && \
	rm -rf /var/lib/apt/lists/*

# digitial ocean in newest version is broken
RUN pip install 'dopy==0.3.5'

# ansible lint
RUN pip install ansible-lint==3.4.4


# kubectl
ENV KUBECTL_VERSION v1.4.6

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl

FROM golang:stretch

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get -y install git vim wget unzip less jq locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV TZ JST-9

ARG ARCH=x86_64
ARG TF_VERSION=latest

RUN RELEASES_URL=https://api.github.com/repos/hashicorp/terraform/releases/latest && \
    if [ "${TF_VERSION}" = "latest" ]; then \
    TF_VERSION=$(curl ${RELEASES_URL} | jq --raw-output '.tag_name' | cut -c 2-); fi && \
    if [ "${ARCH}" = "arm64" ]; then TF_ARCH=${ARCH}; else TF_ARCH=amd64; fi && \
    ZIP_NAME=terraform_${TF_VERSION}_linux_${TF_ARCH}.zip && \
    # terraform install
    wget https://releases.hashicorp.com/terraform/${TF_VERSION}/${ZIP_NAME} && \
    unzip ${ZIP_NAME} -d /usr/local/bin && \
    rm -rf ${ZIP_NAME} && \
    # tfsec install
    go install github.com/aquasecurity/tfsec/cmd/tfsec@latest && \
    # tflint install
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# awscli install
RUN if [ "${ARCH}" = "arm64" ]; then AWSCLI_ARCH=aarch64; else AWSCLI_ARCH=x86_64; fi && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

ARG USERNAME=developer
ARG GROUPNAME=developer
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${GROUPNAME} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME}

USER ${USERNAME}

ENV PATH /usr/local/go/bin:${PATH}

WORKDIR /home/${USERNAME}
RUN curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh && \
    curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
RUN mkdir -p .bash && \
    mv git-prompt.sh .bash && \
    mv git-completion.bash .bash

WORKDIR /home/${USERNAME}/workspace

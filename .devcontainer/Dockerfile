FROM golang:stretch

# hadolint ignore=DL3008
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get -y --no-install-recommends install sudo git vim wget unzip less jq locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV TZ JST-9

ARG TF_VERSION=latest

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN TF_RELEASES_URL=https://api.github.com/repos/hashicorp/terraform/releases/latest && \
    if [ "${TF_VERSION}" = "latest" ]; then \
    TF_DL_VERSION=$(curl ${TF_RELEASES_URL} | jq --raw-output '.tag_name' | cut -c 2-); else \
    TF_DL_VERSION="${TF_VERSION}"; fi && \
    if [ "$(arch)" = "arm64" ] || [ "$(arch)" = "aarch64" ]; then ARCH=arm64; else ARCH=amd64; fi && \
    ZIP_NAME="terraform_${TF_DL_VERSION}_linux_${ARCH}.zip" && \
    # terraform install
    curl -OL "https://releases.hashicorp.com/terraform/${TF_DL_VERSION}/${ZIP_NAME}" && \
    unzip "${ZIP_NAME}" -d /usr/local/bin && \
    rm -rf "${ZIP_NAME}" && \
    # tfsec install
    TFSEC_RELEASES_URL=https://api.github.com/repos/aquasecurity/tfsec/releases/latest && \
    TFSEC_VERSION=$(curl "${TFSEC_RELEASES_URL}" | jq --raw-output '.tag_name' | cut -c 2-) && \
    TAR_NAME=tfsec_${TFSEC_VERSION}_linux_${ARCH}.tar.gz && \
    curl -OL "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/${TAR_NAME}" && \
    tar -xzf "${TAR_NAME}" && \
    rm -rf "${TAR_NAME}" && \
    mv tfsec /usr/local/bin

# awscli install
RUN if [ "$(arch)" = "arm64" ] || [ "$(arch)" = "aarch64" ]; then ARCH=aarch64; else ARCH=x86_64; fi && \
    ZIP_NAME="awscli-exe-linux-${ARCH}.zip" && \
    curl -OL "https://awscli.amazonaws.com/${ZIP_NAME}" && \
    unzip "${ZIP_NAME}" && \
    ./aws/install && \
    rm -rf aws "${ZIP_NAME}"

# session manager plugin install
RUN SSM_PLUGIN_URL_PREFIX=https://s3.amazonaws.com/session-manager-downloads/plugin/latest && \
    if [ "$(arch)" = "arm64" ] || [ "$(arch)" = "aarch64" ]; then SSM_ARCH=arm64; else SSM_ARCH=64bit; fi && \
    curl -o "session-manager-plugin.deb" "${SSM_PLUGIN_URL_PREFIX}/ubuntu_${SSM_ARCH}/session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

ARG USERNAME=developer
ARG GROUPNAME=developer
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${GROUPNAME} && \
    useradd -l -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME} && \
    echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}

ENV PATH /usr/local/go/bin:${PATH}

WORKDIR /home/${USERNAME}
RUN curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh && \
    curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
RUN mkdir -p .bash && \
    mv git-prompt.sh .bash && \
    mv git-completion.bash .bash

WORKDIR /home/${USERNAME}/workspace

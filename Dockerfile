FROM codercom/code-server:4.17.1
USER root
ENV GO_VERSION 1.21.3
ENV PATH=/root/go/bin:/usr/local/go/bin:$PATH
COPY .bashrc /root/.bashrc

RUN set -x \
&& curl -LOs https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -rf /usr/local/go \
&& tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -f go${GO_VERSION}.linux-amd64.tar.gz \
&& echo 'export PATH=/root/go/bin:/usr/local/go/bin:$PATH' >> ~/.profile \
&& mkdir -p /root/go/src \
&& go version

RUN set -x \
&& go install golang.org/x/tools/gopls@latest \
&& go install golang.org/x/tools/cmd/goimports@latest \
&& go install honnef.co/go/tools/cmd/staticcheck@latest \
&& echo

RUN set -x \
&& code-server --install-extension golang.go

RUN set -x \
&& type -p curl >/dev/null || (apt update && apt install curl -y) \
&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install -y \
    gh \
    gcc \
    make \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /root/go

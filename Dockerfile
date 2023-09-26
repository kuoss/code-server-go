FROM codercom/code-server:4.17.0
USER root
ENV GO_VERSION 1.21.1
ENV PATH=/root/go/bin:/usr/local/go/bin:$PATH
COPY .bashrc /root/.bashrc

RUN set -x \
&& curl -LOs https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -rf /usr/local/go \
&& tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -f go${GO_VERSION}.linux-amd64.tar.gz \
&& echo 'export PATH=/root/go/bin:/usr/local/go/bin:$PATH' >> ~/.profile \
&& go version

RUN set -x \
&& go install golang.org/x/tools/gopls@latest \
&& go install golang.org/x/tools/cmd/goimports@latest \
&& go install honnef.co/go/tools/cmd/staticcheck@latest \
&& echo

RUN set -x \
&& code-server --install-extension golang.go

RUN set -x \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
    make \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /root/go

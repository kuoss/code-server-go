FROM codercom/code-server:4.16.1

USER root
ENV GO_VERSION 1.20.8
ENV PATH=/go/bin:/usr/local/go/bin:$PATH
COPY .bashrc /root/.bashrc
RUN set -x \
&& curl -LOs https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -rf /usr/local/go \
&& tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -f go${GO_VERSION}.linux-amd64.tar.gz \
&& echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile \
&& go version
RUN set -x \
&& go install golang.org/x/tools/gopls@latest \
&& go install golang.org/x/tools/cmd/goimports@latest \
&& go install honnef.co/go/tools/cmd/staticcheck@latest \
&& echo
RUN set -x \
&& code-server --install-extension golang.go
WORKDIR /root/go

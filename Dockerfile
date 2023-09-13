FROM codercom/code-server:4.16.1

USER root
ENV GO_VERSION 1.20.8
ENV PATH=/go/bin:/usr/local/go/bin:$PATH
RUN set -x \
&& echo 1 \
&& curl -LOs https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -rf /usr/local/go \
&& tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
&& rm -f go${GO_VERSION}.linux-amd64.tar.gz \
&& go version


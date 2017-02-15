FROM ubuntu:16.04

# RUN gem uninstall bosh_cli -x
RUN apt-get update
RUN apt-get install -y jq curl git ruby-dev wget unzip

RUN apt-get clean
# clean /etc/apt/*.list ?

RUN wget -O /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.147-linux-amd64
RUN chmod +x /usr/local/bin/bosh

RUN curl -L -o vault.zip "https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip"
RUN unzip vault.zip
RUN mv vault /usr/local/bin
RUN chmod +x /usr/local/bin/vault

RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.23.1&source=github-rel" | tar -zx
RUN mv cf /usr/local/bin
RUN rm LICENSE
RUN chmod +x /usr/local/bin/cf

COPY docker/bin/j2y /usr/local/bin
COPY docker/bin/y2j /usr/local/bin
RUN chmod +x /usr/local/bin/y2j
RUN chmod +x /usr/local/bin/j2y

FROM virtmerlin/deploy-worker:latest

RUN rm /usr/local/bin/bosh
RUN wget -O /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.147-linux-amd64
RUN chmod +x /usr/local/bin/bosh
RUN apt-get install -y jq

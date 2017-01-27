FROM virtmerlin/deploy-worker:latest

RUN gem uninstall bosh_cli -x
RUN wget -O /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-0.0.147-linux-amd64
RUN chmod +x /usr/local/bin/bosh

RUN wget -O /tmp/cf-cli.tgz https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.23.1&source=github-rel && sleep 5
RUN tar -C /tmp -xzvf /tmp/cf-cli.tgz
RUN cp /tmp/cf /usr/local/bin/cf
RUN chmod +x /usr/local/bin/cf
RUN rm -rf /tmp/*

RUN apt-get install -y jq

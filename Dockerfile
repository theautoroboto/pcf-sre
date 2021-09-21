FROM ubuntu:18.04
RUN sed -i 's/archive\.ubuntu\.com/us\.archive\.ubuntu\.com/' /etc/apt/sources.list && \
apt-get update -y --fix-missing && apt-get install -y --fix-missing ldap-utils tcpdump telnet iproute2 dnsutils time tcptraceroute inetutils-ping inetutils-traceroute curl build-essential gnupg2 jq git openssl wget netcat ca-certificates apt-transport-https lsb-release \
software-properties-common dirmngr python3 python3-pip ruby ruby-dev vim && \
update-ca-certificates && \
# install azure cli
# old way
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" >> /etc/apt/sources.list.d/azure-cli.list && \
# apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv --keyserver packages.microsoft.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF && \
# apt-get update -y --fix-missing && apt-get install -y azure-cli && \
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && apt-get install -y ./packages-microsoft-prod.deb && \
# install powershell
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && \
apt-get update -y --fix-missing && apt-get install -y powershell && \
# install rubygems
wget https://rubygems.org/rubygems/rubygems-3.0.2.zip && unzip rubygems-3.0.2.zip && ruby -C rubygems-3.0.2 setup.rb && \
# install uaac
/bin/bash -l -c "gem install cf-uaac" && \
# install bosh
wget --no-check-certificate -O /usr/local/bin/bosh $(curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4) && \
chmod +x /usr/local/bin/bosh && \
# install cf
curl -k -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx && mv cf /usr/local/bin && chmod +x /usr/local/bin/cf && \
# install pivnet
wget --no-check-certificate -O /usr/local/bin/pivnet $(curl -s https://api.github.com/repos/pivotal-cf/pivnet-cli/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4) && \
chmod +x /usr/local/bin/pivnet && \
# install om
wget --no-check-certificate -O /usr/local/bin/om $(curl -s https://api.github.com/repos/pivotal-cf/om/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4) && \
chmod +x /usr/local/bin/om && ln -s /usr/local/bin/om /usr/local/bin/om-linux && \
# install mc
wget -O /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc && chmod +x /usr/local/bin/mc && \
# install fly
wget -O fly.tgz https://github.com/concourse/concourse/releases/download/v5.5.3/fly-5.5.3-linux-amd64.tgz && tar -zxvf fly.tgz && mv ./fly /usr/local/bin/fly && rm fly.tgz && \
# install credhub cli
wget --no-check-certificate -O credhub.tgz $(curl -s https://api.github.com/repos/cloudfoundry-incubator/credhub-cli/releases/latest | grep browser_download_url | grep linux | cut -d '"' -f 4) && \
tar -xvf credhub.tgz && mv ./credhub /usr/local/bin/ && rm credhub.tgz && \
# install bbr
wget -O /usr/local/bin/bbr https://github.com/cloudfoundry-incubator/bosh-backup-and-restore/releases/download/v1.5.1/bbr-1.5.1-linux-amd64 && chmod +x /usr/local/bin/bbr && \
# install cf-mgmt binaries
wget --no-check-certificate -O /usr/local/bin/cf-mgmt $(curl -s https://api.github.com/repos/pivotalservices/cf-mgmt/releases/latest | grep browser_download_url | grep mgmt-linux | cut -d '"' -f 4) && \
chmod +x /usr/local/bin/cf-mgmt && \
wget --no-check-certificate -O /usr/local/bin/cf-mgmt-config $(curl -s https://api.github.com/repos/pivotalservices/cf-mgmt/releases/latest | grep browser_download_url | grep mgmt-config-linux | cut -d '"' -f 4) && \
chmod +x /usr/local/bin/cf-mgmt-config && \
# install pks cli
pivnet login --api-token xxx && pivnet download-product-files -p pivotal-container-service -r 1.6.1 -i 579531 -d /usr/local/bin/ && mv /usr/local/bin/pks-linux-amd64* /usr/local/bin/pks && chmod +x /usr/local/bin/pks && \
# install kubectl
pivnet download-product-files -p pivotal-container-service -r 1.6.1 -i 527933 -d /usr/local/bin/ && mv /usr/local/bin/kubectl-linux-amd64* /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

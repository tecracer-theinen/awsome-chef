ARG VARIANT="3.0"
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

ARG CHEF_VERSION=18.0.92
ARG TRAINREST_VERSION=0.5.0
ARG DIRENV_VERSION=2.32.1

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends jq vim direnv yamllint python3-pip python3-setuptools git less python3-dev

COPY .devcontainer/requirements.txt /tmp/
RUN pip3 install --requirement /tmp/requirements.txt

RUN curl --location-trusted https://github.com/direnv/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-amd64 --output /usr/local/bin/direnv --silent \
    && chmod +x /usr/local/bin/direnv

RUN curl --location-trusted https://packages.chef.io/files/current/chef/${CHEF_VERSION}/ubuntu/20.04/chef_${CHEF_VERSION}-1_amd64.deb --output /tmp/chef_${CHEF_VERSION}.deb --silent \
    && dpkg --install /tmp/chef_${CHEF_VERSION}.deb \
    && rm /tmp/chef_${CHEF_VERSION}.deb

# Inject newer version of train-rest
RUN /opt/chef/embedded/bin/gem install train-rest --version $TRAINREST_VERSION \
    && sed -i "s/0.4.2/${TRAINREST_VERSION}/" /opt/chef/bin/chef-client 

# Chef fix post 18.0.130 via Pull Request 13066
RUN cd /opt/chef/embedded/lib/ruby/gems/3.0.0/gems/chef-1* \
    && curl https://patch-diff.githubusercontent.com/raw/chef/chef/pull/13066.patch --silent | patch -p1

# Chef fix post 18.0.130 via Pull Request 13092
RUN cd /opt/chef/embedded/lib/ruby/gems/3.0.0/gems/chef-1* \
    && curl https://patch-diff.githubusercontent.com/raw/chef/chef/pull/13092.patch --silent | patch -p1

RUN echo 'alias awsume="source awsume"' >> /home/vscode/.bashrc \
    && echo 'eval "$(direnv hook bash)"' >> /home/vscode/.bashrc \
    && mkdir /home/vscode/.aws

# Demo Cookbook for Chef's AWS-PSP

This cookbook shows how you can use the AWS Platform Support Pack (PSP) to use Chef together with AWS.

It requires the Chef 18 release and train-rest 0.5.0, which will hopefully be bundled early after release.

## Preparations

If `train-rest` is not yet in the required version, you can install it:

```
sudo /opt/chef/embedded/bin/gem install train-rest --version 0.5.0
```

Please remember to adjust the pinned version of `train-rest` in `/opt/chef/bin/chef-client` from 0.4.2 to 0.5.0

You need to configure the AWS credentials for Chef in Target Mode. 

Either in `~/.chef/credentials` or `/etc/chef/credentials`:

```toml
['staging-vpc']
transport_protocol = 'rest'

endpoint = 'https://cloudcontrolapi.eu-central-1.amazonaws.com'
auth_type = 'awsv4'
```

## Usage (Standalone)

You run the cookbook from a workstation or schedule, as AWS cannot install an agent obviously.

If you want to run this without a server, use Chef Infra's local mode:

```
chef-client -z -r "recipe[awsome-chef]" -t staging-vpc
```

In case you want this to be represented in your Chef Infra/Chef Automate, you have to create a client and put the configuration and certificate in `/etc/chef` as usual. After uploading the cookbook to your server, you can can run the same command without `-z`.

## Usage (VSCode DevContainer)

This repository includes a DevContainer, so you can just click "Open in Remote Container" in your VSCode installation. 

Due to time reasons, I was not able to clean everything up - sorry. I used the following commands to make my demo for ChefConf:

```
sudo mkdir /home/vscode/.chef/staging-vpc/cache
sudo chown vscode /home/vscode/.chef/staging-vpc/cache
sudo mkdir /etc/chef/staging-vpc
sudo cp /home/vscode/.chef/knife.rb /etc/chef/staging-vpc/client.rb
sudo cp /home/vscode/.chef/staging-vpc.pem /etc/chef/staging-vpc/client.pem
sudo cp /home/vscode/.chef/credentials /etc/chef/
sudo chown vscode /etc/chef/staging-vpc/
```

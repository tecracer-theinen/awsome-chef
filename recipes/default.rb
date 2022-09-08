aws_ec2_vpc 'staging-vpc' do
  cidr_block '100.64.0.0/16'

  enable_dns_hostnames true
  enable_dns_support true
end

aws_ec2_subnet 'public-a' do
  vpc_id lazy { rest_id("aws_ec2_vpc[staging-vpc]") }

  cidr_block '100.64.1.0/24'

  availability_zone "#{aws_region}a" # -> eu-central-1a
  map_public_ip_on_launch true
end

aws_ec2_subnet 'public-b' do
  vpc_id lazy { rest_id("aws_ec2_vpc[staging-vpc]") }

  cidr_block '100.64.2.0/24'

  availability_zone "#{aws_region}b" # -> eu-central-1b
  map_public_ip_on_launch true
end

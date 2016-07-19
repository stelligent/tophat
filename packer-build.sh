#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"
berks_cookbook_path="./.berkscache"

for arg in "$@"; do
    if [[ "$arg" = sg-* ]]; then
        TOPHAT_SG="$arg"
    elif [[ "$arg" = subnet-* ]]; then
        TOPHAT_SUBNET_ID="$arg"
    fi
done

subnet_id="$TOPHAT_SUBNET_ID"
sg_id="$TOPHAT_SG"
vpc_id="$(aws ec2 describe-subnets --subnet-ids $subnet_id --query 'Subnets[0].VpcId' --output=text --region ${AWS_REGION})"

test -n "$vpc_id"
test -n "$subnet_id"

[ -d "$berks_cookbook_path" ] || mkdir "$berks_cookbook_path"

declare -A ami_mapping
ami_mapping[us-east-1]=ami-6d1c2007
ami_mapping[us-west-1]=ami-af4333cf
ami_mapping[us-west-2]=ami-d2c924b2

berks vendor "$berks_cookbook_path"
packer build \
    -var "vpc_id=$vpc_id" \
    -var "subnet_id=$subnet_id" \
    -var "berks_cookbooks_path=$berks_cookbook_path" \
    -var "region=${AWS_REGION}" \
    -var "source_ami=${ami_mapping[${AWS_REGION}]}" \
    -var "ssh_username=centos" \
    jenkins.json

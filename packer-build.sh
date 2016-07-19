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

target_os=centos-7
target_os_family=${target_os%%-*}

source_ami=$(ruby -e "require 'yaml'" \
                  -e "puts YAML.load(IO.read('source_amis.yml'))['${AWS_REGION}']['${target_os}']['ami_id']")

ssh_username=$(ruby -e "require 'yaml'" \
                    -e "puts YAML.load(IO.read('source_amis.yml'))['${AWS_REGION}']['${target_os}']['ssh_username']")

berks vendor "$berks_cookbook_path"
packer build \
    -var "target_os_family=${target_os_family}"  \
    -var "vpc_id=$vpc_id" \
    -var "subnet_id=$subnet_id" \
    -var "berks_cookbooks_path=$berks_cookbook_path" \
    -var "region=${AWS_REGION}" \
    -var "source_ami=${source_ami}" \
    -var "ssh_username=${ssh_username}" \
    jenkins.json

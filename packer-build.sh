#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"
berks_cookbook_path="./.berkscache"

for arg in "$@"; do
    if [[ "$arg" = subnet-* ]]; then
        TOPHAT_SUBNET_ID="$arg"
    else
        target_os="$arg"
    fi
done

subnet_id="$TOPHAT_SUBNET_ID"
vpc_id="$(aws ec2 describe-subnets --subnet-ids $subnet_id --query 'Subnets[0].VpcId' --output=text --region ${AWS_REGION})"

test -n "$vpc_id"
test -n "$subnet_id"

[ -d "$berks_cookbook_path" ] || mkdir "$berks_cookbook_path"

target_os_family=${target_os%%-*}

source_ami=$(ruby -e "require 'yaml'" \
                  -e "puts YAML.load(IO.read('source_amis.yml'))['${AWS_REGION}']['${target_os}']['ami_id']")

ssh_username=$(ruby -e "require 'yaml'" \
                    -e "puts YAML.load(IO.read('source_amis.yml'))['${AWS_REGION}']['${target_os}']['ssh_username']")

berks vendor "$berks_cookbook_path"
PACKER_LOG=1 packer build \
    -only ${target_os_family}  \
    -var "vpc_id=$vpc_id" \
    -var "subnet_id=$subnet_id" \
    -var "berks_cookbooks_path=$berks_cookbook_path" \
    -var "region=${AWS_REGION}" \
    -var "source_ami=${source_ami}" \
    -var "ssh_username=${ssh_username}" \
    -var "target_os=${target_os}" \
    jenkins.json

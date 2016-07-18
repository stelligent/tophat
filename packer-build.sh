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
test -n "$sg_id"

[ -d "$berks_cookbook_path" ] || mkdir "$berks_cookbook_path"

berks vendor "$berks_cookbook_path"
packer build \
    -var "vpc_id=$vpc_id" \
    -var "subnet_id=$subnet_id" \
    -var "sg_id=$sg_id" \
    -var "berks_cookbooks_path=$berks_cookbook_path" \
    jenkins.json

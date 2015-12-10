# tophat :tophat:

I'm so over setting up Jenkins servers. This repo contains everything you need to create a Jenkins AMI using Packer. Then you just start using that AMI. So easy.

You already have [Berkshelf](http://berkshelf.com/) and [Packer](https://www.packer.io/intro/getting-started/setup.html) installed, right? Nice.

Make sure you have the [AWS CLI](https://aws.amazon.com/cli/) installed and configured.

You'll also need to have a subnet and security group in which instances will be launched.

Run to build a new Jenkins AMI:

    ./packer-build.sh sg-XXXXXXXX subnet-YYYYYYYY

And then go do some real work.

### Developing

If you're going to develop this cookbook, install [Test Kitchen](http://kitchen.ci/), and set the following
environment variables:

    export TOPHAT_SG=sg-XXXXXXXX
    export TOPHAT_SUBNET_ID=subnet-YYYYYYYY
    export TOPHAT_EC2_KEY=my_ec2_key_name

`.kitchen.yml` looks for those variables when provisioning a new instance.

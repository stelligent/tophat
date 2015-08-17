# tophat :tophat:

I'm so over setting up Jenkins servers. This repo contains everything you need to create a Jenkins AMI using Packer. Then you just start using that AMI. So easy.

You already have [Berkshelf](http://berkshelf.com/) and [Packer](https://www.packer.io/intro/getting-started/setup.html) installed, right? Nice.

Make sure your EC2 credentials are environment variables

    export AWS_ACCESS_KEY_ID='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    export AWS_SECRET_ACCESS_KEY='asdf1234himomhjkl780'
    export region='us-east-1'

And then run

    berks vendor /tmp/berks-cookbooks && \
    packer build \
      -var "vpc_id=your_vpc_id" \
      -var "subnet_id=your_subnet_id" \
      -var "ami_name=jenkins_ami_created_`date +%Y%m%d%H%M%S`" \
      jenkins.json 

And then go do some real work.
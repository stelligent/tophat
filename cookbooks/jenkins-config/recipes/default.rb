# Cookbook name:: jenkins-config
# Recipe:: default
#
# Configure a Jenkins master

include_recipe 'jenkins-config::prereqs'
include_recipe 'java'
include_recipe 'git'
include_recipe 'jenkins::master'
include_recipe 'jenkins-config::jenkins-plugins'
# include_recipe 'jenkins-config::jenkins-jobs'
include_recipe 'jenkins-config::homebin'
include_recipe 'jenkins-config::jenkins-auth'
include_recipe 'jenkins-config::jq'
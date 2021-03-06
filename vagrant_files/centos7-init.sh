#!/usr/bin/env bash

export PUPPET_GEM_VERSION='< 5'

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-nightly-puppetlabs-PC1
yum -y install git puppet-agent vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
mkdir -p /etc/puppetlabs/code/modules
touch /etc/puppetlabs/code/hieradata/global.yaml
gem install bundle librarian-puppet rake --no-rdoc --no-ri
bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code || exit
bundle install
cd /etc/puppetlabs/code/modules/amavisd || exit
rm -f Puppetfile.lock
librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules

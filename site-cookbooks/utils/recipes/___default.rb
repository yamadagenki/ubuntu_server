# -*- coding: utf-8 -*-
# TODO cookbook分割した方がいいと思うんだけど、
# 手元の開発環境整備だけだし、とりあえずこれで

execute "yum.update" do
  command "yum -y update"
  action :run
end

gem_package "rbenv-rehash" do
  action :install
end

execute "resolv.option" do
  command "echo 'options single-request-reopen' >> /etc/resolv.conf"
  action :run
end

execute "gem.update" do
  command "gem update --system"
  action :run
end

execute "rails.install" do
  command "gem install --no-ri --no-rdoc rails"
  action :run
end

%w{openssl-devel readline-devel zlib-devel curl-devel
   libyaml-devel httpd httpd-devel apr-devel apr-util-devel}.each do |p|
  package p do
    action :install
  end
end

gem_package "bundler" do
  action :install
end

gem_package "passenger" do
  action :install
end

execute "passenger.install" do
  command "passenger-install-apache2-module --auto"
  action :run
end

%w{gcc make openssl-devel zlib-devel readline-devel ncurses-devel wget emacs}.each do |p|
  package p do
    action :install
  end
end

%w{git libxml2 libxml2-devel libxslt-devel mysql-devel sqlite-devel ImageMagick}.each do |p|
  package p do
    action :install
  end
end

execute "install IPA font" do
    command <<-EOH
       cd /home/vagrant
       wget http://ipafont.ipa.go.jp/ipafont/IPAfont00303.php
       mkdir /home/vagrant/.fonts
       cp IPAfont00303.zip ~/.fonts
       cd /home/vagrant/.fonts
       unzip IPAfont00303.zip
       fc-cache -fv
    EOH
end


execute "install texlive 2013" do
    command <<-EOH
       cd /vagrant
       wget ftp://tug.org/historic/systems/texlive/2013/texlive2013-20130530.iso
       cd /home/vagrant
       mkdir texlive2013
       sudo mount -o loop -t iso9660 /vagrant/texlive2013-20130530.iso texlive2013
       sudo mkdir -p /mnt/ephemeral/latex_root
       sudo mkdir -p /var/www/html/latex_images
       sudo chmod 777 /mnt/ephemeral/latex_root
       sudo chmod 777 /var/www/html/latex_images
       sudo gem install bundler
       echo "alias sudo='sudo env PATH=$PATH'" >> ~/.bashrc
       source ~/.bashrc
       rbenv rehash
    EOH
end

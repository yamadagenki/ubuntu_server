# -*- coding: utf-8 -*-

# -*- coding: utf-8 -*-
# TODO cookbook分割した方がいいと思うんだけど、
# 手元の開発環境整備だけだし、とりあえずこれで


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

execute "lotus.install" do
  command "gem install lotusrb"
  action :run
end

gem_package "bundler" do
  action :install
end

%w{gcc make wget emacs}.each do |p|
  package p do
    action :install
  end
end

%w{git libxml2 tree}.each do |p|
  package p do
    action :install
  end
end

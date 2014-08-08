#
# Cookbook Name:: coollan
# Recipe:: ssh
#
# Copyright 2014, Oleg Selin
#

package "openssh" do
  action :install
end

template "sshd_config" do
  path "/etc/ssh/sshd_config"
  source "sshd_config.erb"
end

service "sshd" do
  action [:start, :enable]
  subscribes :restart, "template[sshd_config]", :immediately
end

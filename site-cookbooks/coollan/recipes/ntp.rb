#
# Cookbook Name:: coollan
# Recipe:: ntp
#
# Copyright 2014, Oleg Selin
#

package "ntp" do
  action :install
end

template "ntp.conf" do
  path "/etc/ntp.conf"
  source "ntp/ntp.conf.erb"
end

service "ntpd" do
  action [:start, :enable]
  subscribes :restart, "template[ntp.conf]", :immediately
end

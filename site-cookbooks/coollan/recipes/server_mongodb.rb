#
# Cookbook Name:: coollan
# Recipe:: mongodb
#
# Copyright 2014, Oleg Selin
#

package "mongodb" do
  action :install
end

directory "/home/mongodb" do
  owner "mongodb"
  mode 00740
  action :create
end

template "mongodb.conf" do
  path "/etc/mongodb.conf"
  source "mongodb/mongodb.conf.erb"
  notifies :restart, "service[mongodb]", :delayed
end

service "mongodb" do
  action [:start, :enable]
end

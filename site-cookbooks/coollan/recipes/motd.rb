#
# Cookbook Name:: coollan
# Recipe:: motd
#
# Copyright 2014, Oleg Selin
#

template "motd" do
  path "/etc/motd"
  source "motd.erb"
  action :create
end

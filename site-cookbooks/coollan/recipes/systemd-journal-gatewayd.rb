#
# Cookbook Name:: coollan
# Recipe:: systemd-journal-gatewayd
#
# Copyright 2014, Oleg Selin
#

package "libmicrohttpd" do
  action :install
end

service "systemd-journal-gatewayd" do
  action [:start, :enable]
end

#
# Cookbook Name:: coollan
# Recipe:: webmin
#
# Copyright 2014, Oleg Selin
#


package "perl-net-ssleay" do
  action :install
end

package "webmin" do
  action :install
end

template "miniserv.conf" do
  path "/etc/webmin/miniserv.conf"
  source "webmin/miniserv.conf.erb"
end

service "webmin" do
  action [:start, :enable]
  subscribes :restart, "template[miniserv.conf]", :immediately
end

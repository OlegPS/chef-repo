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
  notifies :restart, "service[webmin]", :delayed
end

template "system-status-config" do
  path "/etc/webmin/system-status/config"
  source "webmin/system-status-config.erb"
  notifies :restart, "service[webmin]", :delayed
end

service "webmin" do
  action [:start, :enable]
  subscribes :restart, "template[miniserv.conf]", :immediately
end

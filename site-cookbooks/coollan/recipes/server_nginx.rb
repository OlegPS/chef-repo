#
# Cookbook Name:: coollan
# Recipe:: server_nginx
#
# Copyright 2014, Oleg Selin
#

package "nginx" do
  action :install
end

package "php" do
  action :install
end

package "php-fpm" do
  action :install
end

directory "/etc/nginx/vhosts" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx/nginx.conf.erb"
end

service "nginx" do
  action [:start, :enable]
  subscribes :restart, "template[nginx.conf]", :immediately
end

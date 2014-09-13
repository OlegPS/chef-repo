#
# Cookbook Name:: coollan
# Recipe:: server_backuppc
#
# Copyright 2014, Oleg Selin
#

include_recipe "coollan::server_nginx"

package "perl-file-rsyncp" do
  action :install
end

package "fcgiwrap" do
  action :install
end
package "nfs-utils" do
  action :install
end

package "backuppc" do
  action :install
end

template "backuppc.conf" do
  path "/etc/nginx/vhosts/backuppc.conf"
  source "backuppc/backuppc.conf.erb"
  notifies :restart, resources(:service => "nginx"), :delayed
end

template "config.pl" do
  path "/etc/backuppc/config.pl"
  source "backuppc/config.pl.erb"
end

template "hosts" do
  path "/etc/backuppc/hosts"
  source "backuppc/hosts.erb"
end

cookbook_file "wrapper_BackupPC_Admin" do
  action :create_if_missing
  source "backuppc/wrapper_BackupPC_Admin"
  path "/usr/share/backuppc/cgi-bin/wrapper_BackupPC_Admin"
  owner "backuppc"
  group "http"
  mode "04750"
end

group "backuppc" do
  action :modify
  members "http"
  append true
end

execute 'ssh-keygen' do
  not_if "[ -f /etc/backuppc/id_rsa.pub ] && echo exists"
  user 'backuppc'
  command 'ssh-keygen -t rsa -q -f /etc/backuppc/id_rsa -P ""'
  notifies :run, "ruby_block[ssh-copy-id]"
end

ruby_block "ssh-copy-id" do
  action :nothing
  block do
    node["coollan"]["backuppc"]["hosts"].each do | host |
#      `sudo cat /etc/backuppc/id_rsa.pub | ssh -o "StrictHostKeyChecking no" #{node[:current_user]}@#{host["name"]} 'cat >> /home/#{host["user"]}/.ssh/authorized_keys'`
    end
  end
  subscribes :run, "template[hosts]", :delayed
end

mount "/var/lib/backuppc" do
  device "#{node["coollan"]["backuppc"]["backup"]["device"]}"
  fstype "#{node["coollan"]["backuppc"]["backup"]["fstype"]}"
  options "rw"
  action [:mount, :enable]
end

service "fcgiwrap.socket" do
  action [:start, :enable]
  restart_command "/usr/bin/systemctl stop fcgiwrap.socket; sleep 1; /usr/bin/systemctl start fcgiwrap.socket"
  subscribes :restart, "group[backuppc]", :delayed
end

service "backuppc" do
  action [:start, :enable]
  subscribes :restart, "template[config.pl]", :delayed
end

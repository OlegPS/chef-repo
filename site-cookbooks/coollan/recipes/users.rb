#
# Cookbook Name:: coollan
# Recipe:: users
#
# Copyright 2014, Oleg Selin
#

package "sudo" do
  action :install
end

node["coollan"]["users"]["list"].each do |name, attributes|
  execute "useradd #{name}" do
    not_if "grep #{name} /etc/passwd"
    if "#{attributes["groups"]}".length > 0
      groups = " -G #{attributes["groups"]}"
    end
      command "useradd -g #{attributes["group"]} #{groups} -m -p #{attributes["passwd"]} -s #{attributes["shell"]} -N #{name}"
  end
end

execute "sudo_alias" do
  not_if "cat /etc/sudoers | grep 'Cmnd_Alias CHEF_CMNDS '"
  command "echo 'Cmnd_Alias CHEF_CMNDS = /usr/bin/pacman -S*, /usr/bin/gem, /usr/bin/chef*' >> /etc/sudoers"
end

execute "sudo_user" do
  not_if "cat /etc/sudoers | grep 'chef ALL=(root) NOPASSWD:CHEF_CMNDS'"
  command "echo 'chef ALL=(root) NOPASSWD:CHEF_CMNDS' >> /etc/sudoers"
end

execute "sudo_env" do
  not_if "cat /etc/sudoers | grep 'Defaults:chef '"
  command "echo 'Defaults:chef setenv' >> /etc/sudoers"
end

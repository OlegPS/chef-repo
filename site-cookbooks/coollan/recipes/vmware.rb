#
# Cookbook Name:: coollan
# Recipe:: vmware
#
# Copyright 2014, Oleg Selin
#

package "open-vm-tools" do
  action :install
end

execute "set arch-release" do
  not_if "OLDVER=`[ -f /etc/arch-release ] && cat /etc/arch-release`; NEWVER=`cat /proc/version`; [[ $OLDVER == $NEWVER ]] && echo 1"
  command "cat /proc/version > /etc/arch-release"
end

service "vmtoolsd" do
  action [:start, :enable]
end

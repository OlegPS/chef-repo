#
# Cookbook Name:: coollan
# Recipe:: yaourt
#
# Copyright 2014, Oleg Selin
#

execute "pacman.conf" do
  not_if "cat /etc/pacman.conf | grep 'http://repo.archlinux.fr/$arch'"
  command "printf '\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch\n' >> /etc/pacman.conf; pacman -Sy"
end

package "yaourt" do
  action :install
end

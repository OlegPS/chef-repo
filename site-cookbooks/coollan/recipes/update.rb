#
# Cookbook Name:: coollan
# Recipe:: update
#
# Copyright 2014, Oleg Selin
#

execute "update packages" do
  command "pacman -Suy --noconfirm"
end

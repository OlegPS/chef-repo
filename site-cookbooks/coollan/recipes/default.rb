#
# Cookbook Name:: coollan
# Recipe:: default
#
# Copyright 2014, Oleg Selin
#

include_recipe "coollan::ntp"
include_recipe "coollan::ssh"
include_recipe "coollan::issue"
include_recipe "coollan::motd"
#include_recipe "coollan::ssmtp"
include_recipe "coollan::munin-node"
include_recipe "coollan::webmin"
include_recipe "coollan::users"

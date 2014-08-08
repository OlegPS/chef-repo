#
# Cookbook Name:: coollan
# Recipe:: issue
#
# Copyright 2014, Oleg Selin
#

template "issue" do
  path "/etc/issue"
  source "issue.erb"
  action :create
end

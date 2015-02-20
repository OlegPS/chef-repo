#
# Cookbook Name:: coollan
# Recipe:: server_elasticsearch
#
# Copyright 2014, Oleg Selin
#

package "elasticsearch" do
  action :install
end

directory "/home/elasticsearch" do
  owner "elasticsearch"
  mode 00740
  action :create
end

template "elasticsearch.yml" do
  path "/etc/elasticsearch/elasticsearch.yml"
  source "elasticsearch/elasticsearch.yml.erb"
  notifies :restart, "service[elasticsearch]", :delayed
end

template "default-mapping.json" do
  path "/etc/elasticsearch/default-mapping.json"
  source "elasticsearch/default-mapping.json.erb"
  notifies :restart, "service[elasticsearch]", :delayed
end

service "elasticsearch" do
  action [:start, :enable]
end

#
# Cookbook Name:: coollan
# Recipe:: server_logstash
#
# Copyright 2014, Oleg Selin
#

include_recipe "coollan::yaourt"

execute "yaourt'ing logstash" do
  command "yaourt -Sy logstash --noconfirm --tmp /var/tmp; rm -rf /var/tmp/yaourt*"
  not_if "yaourt -Ss logstash | grep installed"
end

template "systemd-journal-gatewayd.conf" do
  path "/etc/logstash/conf.d/systemd-journal-gatewayd.conf"
  source "logstash/systemd-journal-gatewayd.conf.erb"
  notifies :restart, "service[logstash]", :delayed
end

service "logstash" do
  action [:start, :enable]
end

service "logstash-web" do
  action [:start, :enable]
end

#
# Cookbook Name:: coollan
# Recipe:: ssmtp
#
# Copyright 2014, Oleg Selin
#

package "ssmtp" do
  action :install
end

template "ssmtp.conf" do
  path "/etc/ssmtp/ssmtp.conf"
  source "ssmtp/ssmtp.conf.erb"
end

template "revaliases" do
  path "/etc/ssmtp/revaliases"
  source "ssmtp/revaliases.erb"
  variables ({
     "revaliases" => node["coollan"]["ssmtp"]["revaliases"]
  })
end

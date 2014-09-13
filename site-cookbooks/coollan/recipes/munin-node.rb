#
# Cookbook Name:: coollan
# Recipe:: munin-node
#
# Copyright 2014, Oleg Selin
#

# Install package
package "munin-node" do
  action :install
end

# Create config file
template "munin-node.conf" do
  path "/etc/munin/munin-node.conf"
  source "munin-node/munin-node.conf.erb"
  notifies :restart, "service[munin-node]", :delayed
end

# Plugins config
if node["coollan"]["munin-node"]["plugin"].include? 'df'
  template "df.conf" do
    path "/etc/munin/plugin-conf.d/df.conf"
    source "munin-node/df.conf.erb"
  end
end
if node["coollan"]["munin-node"]["plugin"].include? 'arch_maintenance'
  template "arch_maintenance" do
    path "/usr/lib/munin/plugins/arch_maintenance"
    source "munin-node/arch_maintenance.erb"
    mode 0755
    notifies :restart, "service[munin-node]", :delayed
  end
end

# Add plugins
node["coollan"]["munin-node"]["plugin"].each do | plugin |
  execute "plugin_#{plugin}" do
    command "ln -s '/usr/lib/munin/plugins/#{plugin}' '/etc/munin/plugins/#{plugin}'"
    not_if "[ -f /etc/munin/plugins/#{plugin} ] && echo '1'"
    notifies :restart, "service[munin-node]", :delayed
  end
end

# Enable service
service "munin-node" do
  action [:start, :enable]
end

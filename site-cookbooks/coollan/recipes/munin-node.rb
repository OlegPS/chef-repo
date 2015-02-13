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
if node["coollan"]["munin-node"]["plugins"].include? 'df'
  template "df.conf" do
    path "/etc/munin/plugin-conf.d/df.conf"
    source "munin-node/df.conf.erb"
    notifies :restart, "service[munin-node]", :delayed
  end
end

if node["coollan"]["munin-node"]["plugins"].include? 'proc'
  template "proc.conf" do
#    action :create_if_missing
    path "/etc/munin/plugin-conf.d/proc.conf"
    source "munin-node/proc.conf.erb"
    notifies :restart, "service[munin-node]", :delayed
  end
end

if node["coollan"]["munin-node"]["plugins"].include? 'arch_maintenance'
  template "arch_maintenance" do
    path "/usr/lib/munin/plugins/arch_maintenance"
    source "munin-node/arch_maintenance.erb"
    mode 0755
    notifies :restart, "service[munin-node]", :delayed
  end
  template "arch_maintenance.conf" do
    path "/etc/munin/plugin-conf.d/arch_maintenance.conf"
    source "munin-node/arch_maintenance.conf.erb"
    notifies :restart, "service[munin-node]", :delayed
    mode 0644
  end
end

# Add plugins
node["coollan"]["munin-node"]["plugins"].each do | plugin |
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

#
# Cookbook Name:: coollan
# Recipe:: user
#
# Copyright 2014, Oleg Selin
#


node["coollan"]["userlist"].each do |name, attributes|
  execute "useradd #{name}" do
    not_if "grep #{name} /etc/passwd"
    if "#{attributes["groups"]}".length > 0
      groups = " -G #{attributes["groups"]}"
    end
      command "useradd -g #{attributes["group"]} #{groups} -m -p #{attributes["passwd"]} -s #{attributes["shell"]} -N #{name}"
  end
end

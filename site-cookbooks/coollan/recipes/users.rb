#
# Cookbook Name:: coollan
# Recipe:: users
#
# Copyright 2014, Oleg Selin
#

package "sudo" do
  action :install
end

package "ruby-shadow" do
  action :install
end

node["coollan"]["users"].each do |name, attributes|
  user "#{name}" do
    action :create
    username "#{name}"
    uid attributes["uid"] if attributes["uid"].is_a? Numeric
    gid "#{attributes["group"]}"
    password "#{attributes["password"]}"
    shell "#{attributes["shell"]}" if !attributes["shell"].to_s.empty?
    system true if attributes["system"] == true
    home attributes["home"] if !attributes["home"].to_s.empty?
  end

  if "#{attributes["sudo_cmnd_alias"]}".length > 0
    execute "sudo_alias #{name}" do
      not_if "cat /etc/sudoers.d/#{name} | grep 'Cmnd_Alias #{attributes["sudo_cmnd_alias"].sub(/=.*/, '')}'"
      command "echo 'Cmnd_Alias #{attributes["sudo_cmnd_alias"]}' >> /etc/sudoers.d/#{name}"
    end
  end

  if "#{attributes["sudo_user"]}".length > 0
    execute "sudo_user #{name}" do
      not_if "cat /etc/sudoers.d/#{name} | grep '#{attributes["sudo_user"]}'"
      command "echo '#{name} #{attributes["sudo_user"]}' >> /etc/sudoers.d/#{name}"
    end
  end

  if "#{attributes["sudo_setenv"]}" === "yes"
    execute "sudo_env #{name}" do
      not_if "cat /etc/sudoers.d/#{name} | grep 'Defaults:#{name} '"
      command "echo 'Defaults:#{name} setenv' >> /etc/sudoers.d/#{name}"
    end
  end
end

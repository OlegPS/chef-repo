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
    home "#{attributes["home"]}" if !attributes["home"].to_s.empty?
    supports :manage_home => true
  end

  if !attributes["authorized_keys"].to_s.empty?
    directory "#{attributes["home"]}/.ssh" do
      owner "#{name}"
      group "#{attributes["group"]}"
      mode 0700
      action :create
    end
    template "authorized_keys" do
      path "#{attributes["home"]}/.ssh/authorized_keys"
      source "users/authorized_keys.erb"
      variables :authorized_keys => attributes["authorized_keys"]
    end
  end  

  if !attributes["sudo_cmnd_alias"].to_s.empty?
    execute "sudo_alias #{name}" do
      not_if "cat /etc/sudoers.d/#{name} | grep 'Cmnd_Alias #{attributes["sudo_cmnd_alias"].sub(/=.*/, '')}'"
      command "echo 'Cmnd_Alias #{attributes["sudo_cmnd_alias"]}' >> /etc/sudoers.d/#{name}"
    end
  end

  if !attributes["sudo_user"].to_s.empty?
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

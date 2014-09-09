default["coollan"]["users"]["chef"] = {
  :uid => 10001,
  :password => "QSDl6tjn39WQc",
  :group => "nobody",
  :shell => "/bin/bash",
  :system => true,
  :home => "/home/chef",
  :sudo_cmnd_alias => "CHEF_CMNDS = /usr/bin/pacman -S*, /usr/bin/gem, /usr/bin/chef*",
  :sudo_user => "ALL=(root) NOPASSWD:CHEF_CMNDS",
  :sudo_setenv => "yes"
}

default["coollan"]["users"]["oleg"] = {
  :uid => 10000,
  :password => "yoLhuwhn3kw2w",
  :group => "users",
  :shell => "/bin/bash"
}

default["coollan"]["users"]["backuppc_agent"] = {
  :password => "KOTlIA9RoKNB6",
  :group => "nobody",
  :shell => "/bin/bash",
  :system => true,
  :sudo_user => "ALL=NOPASSWD: /usr/bin/rsync --server --sender *"
}


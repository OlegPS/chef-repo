default["coollan"]["users"]["chef"] = {
  :password => "QSDl6tjn39WQc",
  :group => "nobody",
  :shell => "/bin/bash",
  :home => "/home/chef",
  :sudo_cmnd_alias => "CHEF_CMNDS = /usr/bin/pacman -S*, /usr/bin/gem, /usr/bin/chef*",
  :sudo_user => "ALL=(root) NOPASSWD:CHEF_CMNDS",
  :sudo_setenv => "yes"
}

default["coollan"]["users"]["oleg"] = {
  :password => "yoLhuwhn3kw2w",
  :group => "users",
  :shell => "/bin/bash",
  :home => "/home/oleg"

}

default["coollan"]["users"]["service"] = {
  :group => "nobody",
  :password => "KOTlIA9RoKNB6",
  :shell => "/bin/bash",
  :home => "/home/service",
  :sudo_user => "ALL=NOPASSWD: /usr/bin/rsync --server --sender *",
  :authorized_keys => [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgVbNYsBAjmvY+QoPSyy3u2KEbkTBg5QlqdusuNm7nNIE8jpFptfpjiDFWAVuBiFtLVQbgetcCQvuV29NwlX7I6tJLQ2DP1FTRZPtUg8PVle5SaYQBt6ZIoh0I31FFI2UHcJZy6WCy1ODd/FLPX1osjUcZx+nUEs7+jMmBarIpDRVl9PbW0hiXca/2il/GuiaXHAuzbRM4q/RiATuOzopayzPya/noWMxt6s4Pjf6roP3ufjU7U//NLdnbyoUsXG0tMnb9TX7mPWquBsakFOO1p1IO8qxlSliCuDjoLt9MXRSM7QIDChCDzRMen8BQv0PyGpNaKjSeosl1dQGpL+Tr backuppc@phy1mg2.local"
  ]
}

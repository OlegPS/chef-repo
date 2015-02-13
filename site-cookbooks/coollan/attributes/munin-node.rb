default["coollan"]["munin-node"]["plugins"] = [ "cpu", "memory", "df", "arch_maintenance", "proc" ]
default["coollan"]["munin-node"]["allow"] = [ "95.84.136.90", "192.168.64.104" ]
default["coollan"]["munin-node"]["plugin"]["proc"] = {
	"env.procname" => "vmtoolsd"
}

#default["coollan"]["munin-node"]["plugins"] = {
#  "default" => {
#    "cpu" => "",
#    "memory" => "",
#    "df" => "",
#    "arch_maintenance" => ""
#  }
#}


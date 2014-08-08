log_level                :info
log_location             STDOUT
node_name                'oleg'
client_key               '/home/oleg/.chef/oleg.pem'
validation_client_name   'chef-validator'
validation_key           '/home/oleg/.chef/keys/chef-validator.pem'
chef_server_url          'https://phy1mg2.local:443'
syntax_check_cache_path  '/home/oleg/.chef/syntax_check_cache'
cookbook_path [ 'https://github.com/OlegPS/chef-repo.git/cookbooks' ]

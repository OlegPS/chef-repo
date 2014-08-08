log_level                :info
log_location             STDOUT
node_name                'oleg'
client_key               '/home/oleg/.chef/oleg.pem'
validation_client_name   'chef-validator'
validation_key           '/home/oleg/.chef/keys/chef-validator.pem'
chef_server_url          'https://phy1mg2:443'
ssl_verify_mode          'verify_peer'
syntax_check_cache_path  '/home/oleg/.chef/syntax_check_cache'
cookbook_path            [ 'cookbooks', 'site-cookbooks' ]

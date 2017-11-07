default['icinga2_plugin_mysql']['nagios']['user'] = 'nagios'
default['icinga2_plugin_mysql']['nagios']['group'] = 'nagios'
default['icinga2_plugin_mysql']['nagios']['nagios_plugin_dir'] = '/usr/lib/nagios/plugins'

default['icinga2_plugin_mysql']['git']['repo_path'] = '/usr/local/src/icinga2_mysql_health_chef'
default['icinga2_plugin_mysql']['git']['repo_src_url'] = 'https://github.com/lausser/check_mysql_health.git'
default['icinga2_plugin_mysql']['git']['tag'] = '2.1.2.1'

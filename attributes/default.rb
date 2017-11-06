default['icinga2_plugin_mysql']['env']['perl_path'] = '/usr/bin/perl'

default['icinga2_plugin_mysql']['nagios']['user'] = 'nagios'
default['icinga2_plugin_mysql']['nagios']['group'] = 'nagios'
default['icinga2_plugin_mysql']['nagios']['nagios_plugin_link'] = '/usr/lib/nagios/plugins/check_mysql_health_chef'

default['icinga2_plugin_mysql']['git']['repo_path'] = '/usr/local/src/icinga2_mysql_health_chef'
default['icinga2_plugin_mysql']['git']['repo_src_url'] = 'https://github.com/MelonSmasher/check_mysql_health.git'
default['icinga2_plugin_mysql']['git']['tag'] = '2.1.2.1'

#default['icinga2_plugin_mysql']['mysql']['host'] = 'localhost'
#default['icinga2_plugin_mysql']['mysql']['user'] = ''
#default['icinga2_plugin_mysql']['mysql']['password'] = ''

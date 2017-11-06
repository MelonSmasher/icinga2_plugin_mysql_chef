#
# Cookbook:: icinga2_plugin_mysql
# Recipe:: default
#

### Read attributes and set vars ###
git_repo_path = node['icinga2_plugin_mysql']['git']['repo_path']
git_repo_src_url = node['icinga2_plugin_mysql']['git']['repo_src_url']
git_tag = node['icinga2_plugin_mysql']['git']['tag']

nagios_user = node['icinga2_plugin_mysql']['nagios']['user']
nagios_group = node['icinga2_plugin_mysql']['nagios']['group']
nagios_plugin_link = ['icinga2_plugin_mysql']['nagios']['nagios_plugin_link']

env_perl_path = node['icinga2_plugin_mysql']['env']['perl_path']

#mysql_host = node['icinga2_plugin_mysql']['mysql']['host']
#mysql_user = node['icinga2_plugin_mysql']['mysql']['user']
#mysql_password = node['icinga2_plugin_mysql']['mysql']['password']


### Commands - not run until notified ###
# run configure
execute 'configure' do
  command   "./configure --prefix=#{git_repo_path} " \
            "--with-nagios-user=#{nagios_user} " \
            "--with-nagios-group=#{nagios_group} " \
            "--with-perl=#{env_perl_path} " \
            "--with-statefiles-dir=#{git_repo_path}"
  cwd       git_repo_path
  notifies  :run, 'execute[make]', :immediately
  action    :nothing
end

# run make
execute 'make' do
  command   'make'
  cwd       git_repo_path
  notifies  :run, 'execute[make_check]', :immediately
  action    :nothing
end

# run make health checks
execute 'make_check' do
  command   'make check'
  cwd       git_repo_path
  notifies  :run, 'execute[make_install]', :immediately
  action    :nothing
end

# run make install
execute 'make_install' do
  command   'make install'
  cwd       git_repo_path
  notifies  :create, 'link[link_plugin]', :immediately
  action    :nothing
end

# link the plugin
link 'link_plugin' do
  link_type                  :symbolic
  target_file                File.join(git_repo_path, 'plugins-scripts')
  to                         nagios_plugin_link
  action                     :nothing
end

### Clone the repository ###
# This kicks everything off
git 'icinga2_mysql_checks_chef' do
  destination git_repo_path
  repository  git_repo_src_url
  revision    git_tag
  notifies    :run, 'execute[configure]', :immediately
  action      :sync
end

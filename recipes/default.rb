#
# Cookbook:: icinga2_plugin_mysql
# Recipe:: default
#

# Check what OS family we are on
if %w{rhel debian}.include?(node['platform_family'])

  ### Install any packages that we need ###

  package 'git'

  if node['platform_family'] == 'rhel'
    package %w(gcc gcc-c++ make openssl-devel)
  end

  if node['platform_family'] == 'debian'
    package 'build-essential'
  end

  package %w(autoconf automake) do
    action :remove
  end

  execute 'extract_autoconf' do
    command 'tar xzvf autoconf-2.61.tar.gz'
    cwd '/usr/local/src'
    notifies :run, 'execute[configure_autoconf]', :immediately
    action :nothing
  end

  execute 'configure_autoconf' do
    command './configure'
    cwd '/usr/local/src/autoconf-2.61'
    notifies :run, 'execute[make_autoconf]', :immediately
    action :nothing
  end

  execute 'make_autoconf' do
    command 'make'
    cwd '/usr/local/src/autoconf-2.61'
    notifies :run, 'execute[install_autoconf]', :immediately
    action :nothing
  end

  execute 'install_autoconf' do
    command 'make install'
    cwd '/usr/local/src/autoconf-2.61'
    action :nothing
  end

  remote_file '/usr/local/src/autoconf-2.61.tar.gz' do
    source 'http://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    notifies :run, 'execute[extract_autoconf]', :immediately
    action :create_if_missing
  end

  execute 'extract_automake' do
    command 'tar xzvf automake-1.15.tar.gz'
    cwd '/usr/local/src'
    notifies :run, 'execute[configure_automake]', :immediately
    action :nothing
  end

  execute 'configure_automake' do
    command './configure'
    cwd '/usr/local/src/automake-1.15'
    notifies :run, 'execute[make_automake]', :immediately
    action :nothing
  end

  execute 'make_automake' do
    command 'make'
    cwd '/usr/local/src/automake-1.15'
    notifies :run, 'execute[install_automake]', :immediately
    action :nothing
  end

  execute 'install_automake' do
    command 'make install'
    cwd '/usr/local/src/automake-1.15'
    action :nothing
  end

  remote_file '/usr/local/src/automake-1.15.tar.gz' do
    source 'http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    notifies :run, 'execute[extract_automake]', :immediately
    action :create_if_missing
  end

  ### Read attributes and set vars ###
  git_repo_path = node['icinga2_plugin_mysql']['git']['repo_path']
  git_repo_src_url = node['icinga2_plugin_mysql']['git']['repo_src_url']
  git_tag = node['icinga2_plugin_mysql']['git']['tag']

  nagios_user = node['icinga2_plugin_mysql']['nagios']['user']
  nagios_group = node['icinga2_plugin_mysql']['nagios']['group']
  nagios_plugin_link = node['icinga2_plugin_mysql']['nagios']['nagios_plugin_link']

  env_perl_path = node['icinga2_plugin_mysql']['env']['perl_path']

  #mysql_host = node['icinga2_plugin_mysql']['mysql']['host']
  #mysql_user = node['icinga2_plugin_mysql']['mysql']['user']
  #mysql_password = node['icinga2_plugin_mysql']['mysql']['password']

  ### Commands - not run until notified ###
  # run autoconf
  execute 'autoconf' do
    command "autoconf"
    cwd git_repo_path
    notifies :run, 'execute[configure]', :immediately
    action :nothing
  end
  # run configure
  execute 'configure' do
    command "./configure --prefix=#{git_repo_path} " \
            "--with-nagios-user=#{nagios_user} " \
            "--with-nagios-group=#{nagios_group} " \
            "--with-perl=#{env_perl_path} " \
            "--with-statefiles-dir=#{git_repo_path}"
    cwd git_repo_path
    notifies :run, 'execute[make]', :immediately
    action :nothing
  end

  # run make
  execute 'make' do
    command 'make'
    cwd git_repo_path
    notifies :run, 'execute[make_check]', :immediately
    action :nothing
  end

  # run make health checks
  execute 'make_check' do
    command 'make check'
    cwd git_repo_path
    notifies :run, 'execute[make_install]', :immediately
    action :nothing
  end

  # run make install
  execute 'make_install' do
    command 'make install'
    cwd git_repo_path
    notifies :create, 'link[link_plugin]', :immediately
    action :nothing
  end

  # link the plugin
  link 'link_plugin' do
    link_type :symbolic
    target_file File.join(git_repo_path, 'plugins-scripts')
    to nagios_plugin_link
    action :nothing
  end

  ### Clone the repository ###
  # This kicks everything off
  git 'icinga2_mysql_checks_chef' do
    destination git_repo_path
    repository git_repo_src_url
    revision git_tag
    notifies :run, 'execute[autoconf]', :immediately
    action :sync
  end

end
#
# Cookbook:: icinga2_plugin_mysql
# Recipe:: default
#

# Check what OS family we are on
if %w{rhel debian}.include?(node['platform_family'])

  ### Install any packages / tools that we need ###

  # install git
  package 'git'

  # install build tools for rhel
  if node['platform_family'] == 'rhel'
    package %w(gcc gcc-c++ make openssl-devel)
  end

  # install build tools for deb
  if node['platform_family'] == 'debian'
    package 'build-essential'
  end

  # we can't have these conflict
  package %w(autoconf automake) do
    action :remove
  end

  # extracts the autoconf tar - only runs when triggered by the remote_file download directive
  execute 'extract_autoconf' do
    command 'tar xzvf autoconf-2.61.tar.gz'
    cwd '/usr/local/src'
    notifies :run, 'execute[configure_autoconf]', :immediately
    action :nothing
  end

  # runs the configure script for autoconf - only runs when triggered by the execute tar directive
  execute 'configure_autoconf' do
    command './configure'
    cwd '/usr/local/src/autoconf-2.61'
    notifies :run, 'execute[make_autoconf]', :immediately
    action :nothing
  end

  # makes the autoconf bin - only runs when triggered by the execute configure directive
  execute 'make_autoconf' do
    command 'make'
    cwd '/usr/local/src/autoconf-2.61'
    notifies :run, 'execute[install_autoconf]', :immediately
    action :nothing
  end

  # installs the autoconf bins - only runs when triggered by the execute make directive
  execute 'install_autoconf' do
    command 'make install'
    cwd '/usr/local/src/autoconf-2.61'
    action :nothing
  end

  # downloads the autoconf source
  remote_file '/usr/local/src/autoconf-2.61.tar.gz' do
    source 'http://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    notifies :run, 'execute[extract_autoconf]', :immediately
    action :create_if_missing
  end

  # extracts the automake tar - only runs when triggered by the remote_file download directive
  execute 'extract_automake' do
    command 'tar xzvf automake-1.10.tar.gz'
    cwd '/usr/local/src'
    notifies :run, 'execute[configure_automake]', :immediately
    action :nothing
  end

  # runs the configure script for automake - only runs when triggered by the execute tar directive
  execute 'configure_automake' do
    command './configure'
    cwd '/usr/local/src/automake-1.10'
    notifies :run, 'execute[make_automake]', :immediately
    action :nothing
  end

  # makes the automake bin - only runs when triggered by the execute configure directive
  execute 'make_automake' do
    command 'make'
    cwd '/usr/local/src/automake-1.10'
    notifies :run, 'execute[install_automake]', :immediately
    action :nothing
  end

  # installs the automake bins - only runs when triggered by the execute make directive
  execute 'install_automake' do
    command 'make install'
    cwd '/usr/local/src/automake-1.10'
    action :nothing
  end

  # downloads the automake source
  remote_file '/usr/local/src/automake-1.10.tar.gz' do
    source 'http://ftp.gnu.org/gnu/automake/automake-1.10.tar.gz'
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
  nagios_plugin_target = File.join(node['icinga2_plugin_mysql']['nagios']['nagios_plugin_dir'] , 'check_mysql_health')
  nagios_plugin_source = File.join(git_repo_path, 'plugins-scripts', 'check_mysql_health')

  ### Commands - not run until notified ###
  # run autoconf
  execute 'autoconf' do
    command "autoconf"
    cwd git_repo_path
    notifies :run, 'execute[automake]', :immediately
    action :nothing
  end

  # run automake
  execute 'automake' do
    command "automake -a"
    cwd git_repo_path
    notifies :run, 'execute[configure]', :immediately
    action :nothing
  end

  # run configure
  execute 'configure' do
    command "./configure --prefix=#{git_repo_path} " \
            "--with-nagios-user=#{nagios_user} " \
            "--with-nagios-group=#{nagios_group} "
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
    notifies :create, 'file[copy_plugin]', :immediately
    action :nothing
  end

  # copy the plugin
  remote_file 'copy_plugin' do
    path nagios_plugin_target
    source "file://#{nagios_plugin_source}"
    owner 'root'
    group 'root'
    mode 0755
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
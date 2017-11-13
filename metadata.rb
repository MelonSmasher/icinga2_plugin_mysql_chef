name 'icinga2_plugin_mysql'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'Installs/Configures icinga2_plugin_mysql'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.10'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w(amazon centos debian redhat ubuntu).each do |os|
  supports os
end

issues_url 'https://github.com/MelonSmasher/icinga2_plugin_mysql_chef/issues'
source_url 'https://github.com/MelonSmasher/icinga2_plugin_mysql_chef'

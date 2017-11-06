# icinga2_plugin_mysql

Installs the Nagios MySQL Health Check plugin for icinga2.

## Usage

### sage_cert::default

Just include `sage_cert` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[icinga2_plugin_mysql]"
  ]
}
```

## Attributes

### Perl Path:

Location to Perl binary

Default Value: 

- `/usr/bin/perl`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['env']['perl_path'] = '/usr/bin/perl'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "env": {
      "perl_path": "/usr/bin/perl"
    }
  }
}
```

### Nagios User:

The user that Nagios runs under

Default Value: 

- `nagios`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['nagios']['user'] = 'nagios'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "nagios": {
      "user": "nagios"
    }
  }
}
```

### Nagios Group:

The group that Nagios runs under

Default Value: 

- `nagios`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['nagios']['group'] = 'nagios'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "nagios": {
      "group": "nagios"
    }
  }
}
```

### Nagios Plugin Link Path:

The full path to link this plugin to

Default Value: 

- `/usr/lib/nagios/plugins/check_mysql_health_chef`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['nagios']['nagios_plugin_link'] = '/usr/lib/nagios/plugins/check_mysql_health_chef'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "nagios": {
      "nagios_plugin_link": "/usr/lib/nagios/plugins/check_mysql_health_chef"
    }
  }
}
```

### Git Repo Path:

The local path to clone the plugin source

Default Value: 

- `/usr/local/src/icinga2_mysql_health_chef`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['git']['repo_path'] = '/usr/local/src/icinga2_mysql_health_chef'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "git": {
      "repo_path": "/usr/local/src/icinga2_mysql_health_chef"
    }
  }
}
```

### Plugin Source URL:

The git repository where this plugin's source should be pulled from

Default Value: 

- `https://github.com/MelonSmasher/check_mysql_health.git`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['git']['repo_src_url'] = 'https://github.com/MelonSmasher/check_mysql_health.git'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "git": {
      "repo_src_url": "https://github.com/MelonSmasher/check_mysql_health.git"
    }
  }
}
```

### Git Tag:

The git tag to check this plugin out to.

Default Value: 

- `2.1.2.1`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['git']['tag'] = '2.1.2.1'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "git": {
      "tag": "2.1.2.1"
    }
  }
}
```
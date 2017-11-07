# icinga2_plugin_mysql

Installs the Nagios MySQL Health Check plugin for Nagios/icinga2 using [lausser/check_mysql_health](https://github.com/lausser/check_mysql_health).

## Usage

### icinga2_plugin_mysql::default

Just include `icinga2_plugin_mysql` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[icinga2_plugin_mysql]"
  ]
}
```

## Attributes

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

### Nagios Plugin Dir:

The full path to nagios's plugin dir

Default Value: 

- `/usr/lib/nagios/plugins`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['nagios']['nagios_plugin_dir'] = '/usr/lib/nagios/plugins'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "nagios": {
      "nagios_plugin_dir": "/usr/lib/nagios/plugins"
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

- `https://github.com/lausser/check_mysql_health.git`

Ruby usage:

```ruby
node['icinga2_plugin_mysql']['git']['repo_src_url'] = 'https://github.com/lausser/check_mysql_health.git'
```

JSON usage:

```json
{
  "icinga2_plugin_mysql": {
    "git": {
      "repo_src_url": "https://github.com/lausser/check_mysql_health.git"
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

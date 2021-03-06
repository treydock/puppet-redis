# == Class: redis::config
#
# This class provides configuration for Redis.
#
class redis::config {
  File {
    owner  => $::redis::config_owner,
    group  => $::redis::config_group,
    mode   => $::redis::config_file_mode,
    notify => Service[$::redis::service_name],
  }

  file {
    $::redis::config_dir:
      ensure => directory,
      mode   => $::redis::config_dir_mode;

    $::redis::config_file:
      ensure  => present,
      content => template('redis/redis.conf.erb');

    $::redis::log_dir:
      ensure => directory,
      group  => $::redis::service_group,
      mode   => $::redis::config_dir_mode,
      owner  => $::redis::service_user;
  }
}


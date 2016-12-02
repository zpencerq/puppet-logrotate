# == Class: logrotate::params
#
# Params class for logrotate module
#
class logrotate::params {
  $cron_daily_hour    = 1
  $cron_daily_minute  = 0
  $cron_hourly_minute = 1
  $logrotate_conf     = "${configdir}/logrotate.conf"
  $root_user          = 'root'
  $rules_configdir    = "${configdir}/logrotate.d"
  $config_file = '/etc/logrotate.conf'

  case $::osfamily {
    'FreeBSD': {
      $configdir     = '/usr/local/etc'
      $root_group    = 'wheel'
      $logrotate_bin = '/usr/local/sbin/logrotate'
      $conf_params   = {}
    }
    'Debian': {
      $default_su_group = versioncmp($::operatingsystemmajrelease, '14.00') ? {
        1         => 'syslog',
        default   => undef
      }
      $conf_params = {
        su_group => $default_su_group,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
    }
    'Gentoo': {
      $conf_params = {
        dateext  => true,
        compress => true,
        ifempty  => false,
        mail     => false,
        olddir   => false,
      }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
    }
    default: {
      $conf_params = { }
      $configdir     = '/etc'
      $root_group    = 'root'
      $logrotate_bin = '/usr/sbin/logrotate'
    }
  }
}

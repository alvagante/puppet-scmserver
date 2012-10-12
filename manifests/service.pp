# Class: scmserver::service
#
# This class manages scmserver services
#
# == Variables
#
# Refer to scmserver class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by scmserver
#
class scmserver::service inherits scmserver {

  case $scmserver::install {

    package: {
      service { 'scmserver':
        ensure     => $scmserver::manage_service_ensure,
        name       => $scmserver::service,
        enable     => $scmserver::manage_service_enable,
        hasstatus  => $scmserver::service_status,
        pattern    => $scmserver::process,
        require    => Package['scmserver'],
      }
    }

    source,puppi: {
      service { 'scmserver':
        ensure     => $scmserver::manage_service_ensure,
        name       => $scmserver::service,
        enable     => $scmserver::manage_service_enable,
        hasstatus  => $scmserver::service_status,
        pattern    => $scmserver::process,
        require    => File['scmserver.init'],
      }
      file { 'scmserver.init':
        ensure  => $scmserver::manage_file,
        path    => "/etc/init.d/${scmserver::service}",
        mode    => '0755',
        owner   => $scmserver::config_file_owner,
        group   => $scmserver::config_file_group,
        require => Class['scmserver::install'],
        notify  => $scmserver::manage_service_autorestart,
        content => template($scmserver::real_init_script_template),
        audit   => $scmserver::manage_audit,
      }
    }

    default: { }

  }


  ### Service monitoring, if enabled ( monitor => true )
  if $scmserver::bool_monitor == true {
    monitor::port { "scmserver_${scmserver::protocol}_${scmserver::port}":
      protocol => $scmserver::protocol,
      port     => $scmserver::port,
      target   => $scmserver::monitor_target,
      tool     => $scmserver::monitor_tool,
      enable   => $scmserver::manage_monitor,
    }
    monitor::process { 'scmserver_process':
      process  => $scmserver::process,
      service  => $scmserver::service,
      pidfile  => $scmserver::pid_file,
      user     => $scmserver::process_user,
      argument => $scmserver::process_args,
      tool     => $scmserver::monitor_tool,
      enable   => $scmserver::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $scmserver::bool_firewall == true {
    firewall { "scmserver_${scmserver::protocol}_${scmserver::port}":
      source      => $scmserver::firewall_src,
      destination => $scmserver::firewall_dst,
      protocol    => $scmserver::protocol,
      port        => $scmserver::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $scmserver::firewall_tool,
      enable      => $scmserver::manage_firewall,
    }
  }

}

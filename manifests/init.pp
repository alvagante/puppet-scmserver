# = Class: scmserver
#
# This is the main scmserver class
#
#
# == Parameters
#
# Module Specific params
#
# [*version*]
#   The scmserver version you want to install. The default install_source is
#   calculated according to itu.
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs scmserver using the OS common packages
#     - source  : Installs scmserver downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs scmserver tarball or file via Puppi, creating the
#                 "puppi deploy scmserver" command
#   Can be defined also by the variable $scmserver_install
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the variable $scmserver_install_source
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Can be defined also by the variable $scmserver_install_destination
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check scmserver/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $scmserver_install_precommand
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check scmserver/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $scmserver_install_postcommand
#
# [*init_script_template*]
#   The template to use to create the init script.
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, scmserver class will automatically "include $my_class"
#   Can be defined also by the variable $scmserver_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, scmserver main config file will have the param:
#   source => $source
#   Can be defined also by the variable $scmserver_source
#
# [*source_dir*]
#   If defined, the whole scmserver configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the variable $scmserver_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the variable $scmserver_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, scmserver main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the variable $scmserver_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the variable $scmserver_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the variable $scmserver_absent
#
# [*service_autorestart*]
#   Automatically restarts the scmserver service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $scmserver_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $scmserver_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the variables $scmserver_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for scmserver checks
#   Can be defined also by the variables $scmserver_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the variables $scmserver_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the variables $scmserver_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the variables $scmserver_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $scmserver_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for scmserver port(s)
#   Can be defined also by the (top scope) variables $scmserver_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling scmserver. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $scmserver_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $scmserver_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the variables $scmserver_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the variables $scmserver_audit_only
#   and $audit_only
#
# Default class params - As defined in scmserver::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of scmserver package
#
# [*service*]
#   The name of scmserver service
#
# [*service_status*]
#   If the scmserver service init script supports status argument
#
# [*process*]
#   The name of scmserver process
#
# [*process_args*]
#   The name of scmserver arguments. Used by puppi and monitor.
#   Used only in case the scmserver process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user scmserver runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $scmserver_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $scmserver_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include scmserver"
# - Call scmserver as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class scmserver (
  $version             = params_lookup( 'version' ),
  $install             = params_lookup( 'install' ),
  $install_source      = params_lookup( 'install_source' ),
  $install_destination = params_lookup( 'install_destination' ),
  $install_precommand  = params_lookup( 'install_precommand' ),
  $install_postcommand = params_lookup( 'install_postcommand' ),
  $init_script_template = params_lookup( 'init_script_template' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits scmserver::params {

  ### VARIABLES

  ### Variables reduced to booleans
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $scmserver::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $scmserver::bool_disableboot ? {
    true    => false,
    default => $scmserver::bool_disable ? {
      true    => false,
      default => $scmserver::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $scmserver::bool_disable ? {
    true    => 'stopped',
    default =>  $scmserver::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $scmserver::bool_service_autorestart ? {
    true    => Service[scmserver],
    false   => undef,
  }

  $manage_file = $scmserver::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $scmserver::bool_absent == true
  or $scmserver::bool_disable == true
  or $scmserver::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $scmserver::bool_absent == true
  or $scmserver::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $scmserver::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $scmserver::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $scmserver::source ? {
    ''        => undef,
    default   => $scmserver::source,
  }

  $manage_file_content = $scmserver::template ? {
    ''        => undef,
    default   => template($scmserver::template),
  }

  ### Calculations of variables whoe value depends on different params
  $real_install_source = $scmserver::install_source ? {
    ''      => $scmserver::version ? {
      ''      => 'http://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/1.15/scm-server-1.15-app.zip',
      default => "http://maven.scm-manager.org/nexus/content/repositories/releases/sonia/scm/scm-server/${scmserver::version}/scm-server-${scmserver::version}-app.zip",
    },
    default => $scmserver::install_source,
  }

  $real_install_destination = $scmserver::install_destination ? {
    ''      => '/opt',
    default => $scmserver::install_destination,
  }

  $real_scmserver_dir = "$real_install_destination/scm-server"

  $real_config_file = $scmserver::config_file ? {
    ''      => "${scmserver::real_scmserver_dir}/conf/server-config.xml",
    default => $scmserver::config_file,
  }

  $real_config_dir = $scmserver::config_dir ? {
    ''      => $scmserver::install ? {
      package => $::operatingsystem ? {
        default => '/etc/scm-server',
      },
      default => "${scmserver::real_scmserver_dir}/conf/",
    },
    default => $scmserver::config_dir,
  }

  $real_data_dir = $scmserver::data_dir ? {
    ''      => $scmserver::install ? {
      package => '/usr/share/scmserver',
      default => "${scmserver::real_scmserver_dir}/",
    },
    default => $scmserver::data_dir,
  }

  $real_init_script_template = $scmserver::init_script_template ? {
    ''      => 'scmserver/scmserver.init.erb',
    default => $scmserver::init_script_template,
  }

  $real_pid_file = $scmserver::pid_file ? {
    ''      => $scmserver::install ? {
      package => '/var/run/scm-server.pid',
      default => "${scmserver::real_scmserver_dir}/",
    },
    default => $scmserver::pid_file,
  }

  $real_log_dir = $scmserver::log_dir ? {
    ''      => $scmserver::install ? {
      package => '/var/log/scm-server',
      default => "${scmserver::real_scmserver_dir}/var/log",
    },
    default => $scmserver::log_dir,
  }

  $real_log_file = $scmserver::log_file ? {
    ''      => $scmserver::install ? {
      package => ['/var/log/scmserver.out','/var/log/scm-server.err'] ,
      default => [ "${scmserver::real_scmserver_dir}/var/log/scm-server.out",
                   "${scmserver::real_scmserver_dir}/var/log/scm-server.err" ],
    },
    default => $scmserver::log_file,
  }


  ### Managed resources
  # Installation is managed in a dedicated class
  require scmserver::install

  # Service is managed in a dedicated class
  require scmserver::service

  if ($scmserver::source or $scmserver::template) {
    file { 'scmserver.conf':
      ensure  => $scmserver::manage_file,
      path    => $scmserver::real_config_file,
      mode    => $scmserver::config_file_mode,
      owner   => $scmserver::config_file_owner,
      group   => $scmserver::config_file_group,
      require => Class['scmserver::install'],
      notify  => $scmserver::manage_service_autorestart,
      source  => $scmserver::manage_file_source,
      content => $scmserver::manage_file_content,
      replace => $scmserver::manage_file_replace,
      audit   => $scmserver::manage_audit,
    }
  }

  # The whole scmserver configuration directory can be recursively overriden
  if $scmserver::source_dir {
    file { 'scmserver.dir':
      ensure  => directory,
      path    => $scmserver::real_config_dir,
      require => Class['scmserver::install'],
      notify  => $scmserver::manage_service_autorestart,
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $scmserver::manage_file_replace,
      audit   => $scmserver::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $scmserver::my_class {
    include $scmserver::my_class
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $scmserver::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'scmserver':
      ensure    => $scmserver::manage_file,
      variables => $classvars,
      helper    => $scmserver::puppi_helper,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $scmserver::bool_debug == true {
    file { 'debug_scmserver':
      ensure  => $scmserver::manage_file,
      path    => "${settings::vardir}/debug-scmserver",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}

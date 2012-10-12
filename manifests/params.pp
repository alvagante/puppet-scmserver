# Class: scmserver::params
#
# This class defines default parameters used by the main module class scmserver
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to scmserver class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class scmserver::params {

  ### Module specific parameters
  $version = ''
  $install = 'source'
  $install_precommand = ''
  $install_postcommand = ''
  $init_script_template = ''

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'scm-server',
  }

  $service = $::operatingsystem ? {
    default => 'scm-server',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'scm-server',
  }

  $process_user = $::operatingsystem ? {
    default => 'scm-server',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'scm-server',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'scm-server',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/scm-server.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/lib/scm-server',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/scm-server',
  }

  $log_file = $::operatingsystem ? {
    default => ['/var/log/scm-server.out','/var/log/scm-server.err'],
  }

  $port = '8080'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = ''
  $options = ''
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'java'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/24'
  $firewall_dst = $::ipaddress
  $debug = false
  $audit_only = false

}

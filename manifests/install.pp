# Class: scmserver::install
#
# This class installs scmserver
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
class scmserver::install inherits scmserver {

  case $scmserver::install {

    package: {
      package { 'scmserver':
        ensure => $scmserver::manage_package,
        name   => $scmserver::package,
      }
    }

    source: {

      $created_dirname = 'scm-server'

      require scmserver::user

      puppi::netinstall { 'netinstall_scmserver':
        url                 => $scmserver::real_install_source,
        destination_dir     => "${scmserver::real_install_destination}/" ,
        preextract_command  => $scmserver::install_precommand,
        postextract_command => "chown -R ${scmserver::process_user}:${scmserver::process_user} ${scmserver::real_install_destination}/${created_dirname}",
        extracted_dir       => $created_dirname,
        owner               => $scmserver::process_user,
        group               => $scmserver::process_user,
        require             => User[$scmserver::process_user],
      }

    }

    puppi: {

      require scmserver::user

      puppi::project::archive { 'scmserver':
        source                   => $scmserver::real_install_source,
        deploy_root              => $scmserver::real_install_destination,
        predeploy_customcommand  => $scmserver::install_precommand,
        postdeploy_customcommand => $scmserver::install_postcommand,
        report_email             => 'root',
        user                     => $scmserver::process_user,
        auto_deploy              => true,
        enable                   => true,
        require                  => User[$scmserver::process_user],
      }

    }

    default: { }

  }

}

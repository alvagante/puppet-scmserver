# Class: scmserver::user
#
# This class creates scmserver user
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by scmserver
#
class scmserver::user inherits scmserver {
  @user { $scmserver::process_user :
    ensure     => $scmserver::manage_file,
    comment    => "${scmserver::process_user} user",
    password   => '!',
    managehome => false,
    home       => $scmserver::real_scmserver_dir,
    shell      => '/bin/bash',
    before     => Group['scm-server'] ,
  }
  @group { $scmserver::process_user :
    ensure     => $scmserver::manage_file,
  }

  User <| title == $scmserver::process_user |>
  Group <| title == $scmserver::process_user |>

}

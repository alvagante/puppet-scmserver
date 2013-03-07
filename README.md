# Puppet module: scmserver

This is a Puppet module that installs scmserver:
https://bitbucket.org/sdorra/scm-manager/wiki/Home

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-scmserver

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module.

For detailed info about the logic and usage patterns of Example42 modules read README.usage on Example42 main modules set.

## USAGE - Basic management

* Install scmserver via the upstream zip

        class { "scmserver": }

* Install the latest scmserver version from upstream site

        class { "scmserver":
          install             => "source",
        }

* Install the latest scmserver version from upstream site using puppi. 
  You will have a 'puppi deploy scmserver' to deploy and update scmserver.

        class { "scmserver":
          install             => "puppi",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check scmserver/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "scmserver":
          install             => "source",
          install_source      => "http://deploy.example42.com/scmserver/scmserver.tar.gz",
        }

* Remove scmserver

        class { "scmserver":
          absent => true
        }

* Enable auditing without without making changes on existing scmserver configuration files

        class { "scmserver":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "scmserver":
          source => [ "puppet:///modules/lab42/scmserver/wp-config.php-${hostname}" , "puppet:///modules/lab42/scmserver/wp-config.php" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "scmserver":
          source_dir       => "puppet:///modules/lab42/scmserver/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "scmserver":
          template => "example42/scmserver/wp-config.php.erb",      
        }

* Automaticallly include a custom subclass

        class { "scmserver:"
          my_class => 'scmserver::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "scmserver": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "scmserver":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "scmserver":
          monitor      => true,
          monitor_tool => [ "nagios" , "puppi" ],
        }


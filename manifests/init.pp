# == Class: role_reverseproxy
#
# Full description of class role_reverseproxy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'role_reverseproxy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_reverseproxy {

  class {'nginx':}


  #### OPENSTACK
  nginx::resource::vhost { 'openstack.naturalis.nl': proxy => 'http://openstack_naturalis_nl', }

  nginx::resource::upstream { 'openstack_naturalis_nl': members => [' 10.61.2.89:80'], }

  #### MEDIALIB OAI-PMH
  nginx::resource::vhost { 'webservices.naturalis.nl': proxy    => 'http://webservices_medialib_oai-pmh', }

  nginx::resource::upstream { 'webservices_medialib_oai-pmh': members => ['10.61.2.58:80',], }

  nginx::resource::location{ 'medialib_oaipmh':
    location => 'webservices.naturalis.nl/medialib/oai-pmh',
    vhost    => 'webservices.naturalis.nl',
    proxy    => 'http://webservices_medialib_oai-pmh/medialib/oai-pmh'
  }

  #### CATALOGUE OF LIFE

  nginx::resource::upstream {'134_213_57_40':  members => ['134.213.57.40:80'], }
  nginx::resource::upstream {'46_149_28_153':  members => ['46.149.28.153:80'], }
  nginx::resource::upstream {'46_149_20_81' :  members => ['46.149.20.81:80'], }
  nginx::resource::upstream {'46_149_29_25' :  members => ['46.149.29.25:80'], }

  nginx::resource::vhost {'www.catalogueoflife.* catalogueoflife.*': proxy    => 'http://134_213_57_40', }

  nginx::resource::location{ '46_149_29_25_testcol':
    location => '/testcol',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_29_25/$request_url'
  }

  nginx::resource::location{ '46_149_29_25_piping':
    location => '/piping',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_29_25/piping'
  }

  nginx::resource::location{ '46_149_29_25_tree_estiamtes':
    location => '/tree_estimates',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_29_25/tree_estimates'
  }

  nginx::resource::location{ '46_149_20_81_DCA_Export':
    location => '/DCA_Export',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/DCA_Export'
  }

  # nginx::resource::location{ '46_149_28_153_DCA_Export':
  #   location => '/annual-checklist/',
  #   vhost    => 'www.catalogueoflife.* catalogueoflife.*',
  #   proxy    => 'http://46_149_28_153/DCA_Export'
  # }
  #
  # nginx::resource::location{ '46_149_28_153_DCA_Export':
  #   location => '/annual-checklist/',
  #   vhost    => 'www.catalogueoflife.* catalogueoflife.*',
  #   proxy    => 'http://46_149_20_81/DCA_Export'
  # }





}

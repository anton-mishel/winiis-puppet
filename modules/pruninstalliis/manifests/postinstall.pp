class pruninstalliis::postinstall {
windowsfeature { 'Web-Stat-Compression':
      ensure => absent,
      require => Class['pruninstalliis::install'],
    }
      windowsfeature { 'Web-Dyn-Compression':
      ensure => absent,
      require => Class['pruninstalliis::install'],
    }
}

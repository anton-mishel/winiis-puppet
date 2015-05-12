class pruninstalliis::postinstall {
windowsfeature { 'Web-Stat-Compression':
      ensure => absent,
      require => Class['pruninstalliis::install'],
    }
      windowsfeature { 'Web-Dyn-Compression':
      ensure => absent,
      require => Class['pruninstalliis::install'],
    }
exec { "Configure_iis_errors" :
      command   => "Import-Module WebAdministration;Set-WebConfigurationProperty -pspath \'IIS:\\\' -filter system.webServer/httpErrors -name errorMode  -value Detailed ",
      provider  => 'powershell',
      logoutput => true,
      require   => Class['pruninstalliis::install' ],
    }
}

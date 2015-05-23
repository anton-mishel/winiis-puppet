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
exec { "isapi-restrictions" :
      command => "Add-WebConfiguration -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.webServer/security/isapiCgiRestriction' -value @{\ndescription = 'PRUN'\npath        = 'C:\inetpub\scripts\prun.dll'\n    allowed     = 'True'\n}",
      provider  => 'powershell',
      logoutput => true,
      require   => Class['pruninstalliis::install' ],
    }
exec { "disable-ssl2" :
      command => "Add-WebConfiguration -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.webServer/security/isapiCgiRestriction' -value @{\ndescription = 'PRUN'\npath        = 'C:\inetpub\scripts\prun.dll'\n    allowed     = 'True'\n}",
      provider  => 'powershell',
      logoutput => true,
    }
 registry::value { 'SSL2.0':
    key  => 'HKLM\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server',
    value => 'Enabled',
    type => 'dword',
    data => '00000000',
  }
 registry::value { 'SSL3.0':
    key  => 'HKLM\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server',
    type => 'dword',
    value => 'Enabled',
    data => '00000000',
  }
}

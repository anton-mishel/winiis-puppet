class pruninstalliis::postinstall {
#Disable compression
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
      #command => "Add-WebConfiguration -pspath 'IIS:\' -filter 'system.webServer/security/isapiCgiRestriction' -value @{\ndescription = 'PRUN'\npath        = 'C:\inetpub\scripts\prun.dll'\n    allowed     = 'True'\n}",
      command => "Add-WebConfiguration -pspath 'IIS:\' -filter 'system.webServer/security/isapiCgiRestriction' -value @{description='PRUN';path='C:\inetpub\scripts\prun.dll';allowed='True'}",
      #command => "Add-WebConfiguration -pspath 'IIS:\' -filter 'system.webServer/security/isapiCgiRestriction' -value @{path='C:\inetpub\scripts\prun.dll'}",
      provider  => 'powershell',
      logoutput => true,
      require   => Class['pruninstalliis::install' ],
    }
#Disable SSL 2.0 and 3.0 in registry 
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
#Default app pool configuration

exec { "Configure_defaultapppool" :
      command => "Import-Module WebAdministration \nSet-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name enable32BitAppOnWin64 -Value True\nSet-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name managedRuntimeVersion -Value \"\" \nSet-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name managedPipelineMode -Value \"Classic\"\n Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name queueLength -Value 65535 \nSet-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name processModel.idleTimeout -Value \"0\"\n Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool\' -Name Recycling.PeriodicRestart -Value '0'",
      provider  => 'powershell',
      logoutput => true,
      require   => Class['pruninstalliis::install' ],
    }
}

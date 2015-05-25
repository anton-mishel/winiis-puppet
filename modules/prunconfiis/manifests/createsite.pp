define prunconfiis::createsite ($iis_site_name,$iis_host_header,$iis_site_path,$iis_site_http_port,$iis_site_https_port,$iis_certificate_thumbprint) {

iis::manage_site {$iis_site_name:
    site_path     => $iis_site_path,
    port          => $iis_site__http_port,
    ip_address    => '*',
    host_header   => $iis_host_header,
    app_pool      => 'DefaultAppPool'
  }

iis::manage_virtual_application {'scripts':
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\scripts',
    app_pool    => 'DefaultAppPool'
  }
exec { 'Set-Access-Policy-Scripts':
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/scripts' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }

iis::manage_virtual_application {'auth':
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\scripts',
    app_pool    => 'DefaultAppPool'
  }
exec { 'Set-Access-Policy-Auth':
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/auth' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }
## Disable anonymous auth
exec { 'anonymousAuthentication':
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/anonymousAuthentication' -Name Enabled -Value False -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }
## Enable Basic  auth
exec { 'basicAuthentication':
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/basicAuthentication' -Name Enabled -Value True -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }
## Enable Windows  auth
exec { 'windowsAuthentication':
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/windowsAuthentication' -Name Enabled -Value True -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }



iis::manage_virtual_application {'applets':
    site_name   => $iis_site_name,
    site_path   => 'c:\humanclick\server\applets',
    app_pool    => 'DefaultAppPool'
  }

iis::manage_virtual_application {'corda':
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\corda',
    app_pool    => 'DefaultAppPool'
  }
exec { 'Set-Access-Policy-Corda':
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/corda' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }

iis::manage_virtual_directory {'hcp':
    directory  => 'hcp',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server\images'
  }

iis::manage_virtual_directory {'lpWeb':
    directory  => 'lpWeb',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server.web'
  }

iis::manage_virtual_directory {'xdespellchecker':
    directory  => 'xdespellchecker',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server\xdespellchecker\serverfiles'
  }


#Add handler mapping 
exec { 'addhandlermapping':
      command => "New-WebHandler -Name 'PRUN' -Path '*' -ScriptProcessor 'c:\inetpub\scripts\prun.dll'  -Verb '*'  -Modules 'IsapiModule' -PSPath 'IIS:\' -Location $iis_site_name",
      provider  => 'powershell',
      logoutput => true,
    }
# New-WebHandler -Name "PRUN" -Path "*" -ScriptProcessor "c:\inetpub\scripts\prun.dll"  -Verb '*'  -Modules "IsapiModule" -PSPath "IIS:\" -Location 'Default Web Site'

iis::manage_binding {$iis_site_name:
    site_name    => $iis_site_name,
    protocol     => 'https',
    port          => $iis_site_https_port,
    ip_address    => '*',
    host_header   => $iis_host_header,
    certificate_thumbprint => $iis_certificate_thumbprint 
  }

} 

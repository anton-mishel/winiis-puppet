define prunconfiis::createsite ($iis_site_name,$iis_host_header,$iis_site_path,$iis_site_http_port,$iis_site_https_port,$iis_certificate_thumbprint) {

iis::manage_site {$iis_site_name:
    site_path     => $iis_site_path,
    port          => $iis_site__http_port,
    ip_address    => '*',
    host_header   => $iis_host_header,
    app_pool      => 'DefaultAppPool'
  }

iis::manage_virtual_application {"$iis_site_name}/scripts":
    virtual_application_name => 'scripts',
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\scripts',
    app_pool    => 'DefaultAppPool'
  }

iis::manage_virtual_application {"${iis_site_name}/auth":
    virtual_application_name => 'auth',
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\scripts',
    app_pool    => 'DefaultAppPool'
  }
iis::manage_virtual_application {"${iis_site_name}/applets":
    virtual_application_name => 'appliets',
    site_name   => $iis_site_name,
    site_path   => 'c:\humanclick\server\applets',
    app_pool    => 'DefaultAppPool'
  }

iis::manage_virtual_application {"${iis_site_name}/corda":
    virtual_application_name => 'corda',
    site_name   => $iis_site_name,
    site_path   => 'c:\inetpub\corda',
    app_pool    => 'DefaultAppPool'
  }

iis::manage_virtual_directory {"${iis_site_name}/hcp":
    directory  => 'hcp',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server\images'
  }

iis::manage_virtual_directory {"${iis_site_name}/lpWeb":
    directory  => 'lpWeb',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server.web'
  }

iis::manage_virtual_directory {"${iis_site_name}/xdespellchecker":
    directory  => 'xdespellchecker',
    site_name   => $iis_site_name,
    path    => 'c:\humanclick\server\xdespellchecker\serverfiles'
  }
## Access policy section
exec { "${iis_site_name}/Set-Access-Policy-Scripts":
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/scripts' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }
exec {  "${iis_site_name}/Set-Access-Policy-Auth":
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/auth' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }
## Disable anonymous auth
exec { "${iis_site_name}/anonymousAuthentication":
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/anonymousAuthentication' -Name Enabled -Value False -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }
## Enable Basic  auth
exec { "${iis_site_name}/basicAuthentication":
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/basicAuthentication' -Name Enabled -Value True -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }
## Enable Windows  auth
exec { "${iis_site_name}/windowsAuthentication":
      command => "Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/windowsAuthentication' -Name Enabled -Value True -PSPath 'IIS:\' -Location '${iis_site_name}/auth'",
      provider  => 'powershell',
      logoutput => true,
    }

exec { "${iis_site_name}/Set-Access-Policy-Corda":
      command => "Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location '${iis_site_name}/corda' -Value 'Read,Script,Execute'",
      provider  => 'powershell',
      logoutput => true,
    }


#Add handler mapping 
exec { "${iis_site_name}/addhandlermapping":
      #command => "New-WebHandler -Name 'PRUN' -Path '*' -ScriptProcessor 'c:\inetpub\scripts\prun.dll'  -Verb '*'  -Modules 'IsapiModule' -PSPath 'IIS:\' -Location $iis_site_name",
      command => "C:\Windows\System32\inetsrv\appcmd.exe set config /section:handlers /+[name='PRUN',path='*',verb='*',modules='IsapiModule',scriptProcessor='c:\inetpub\\scripts\prun.dll',resourceType='Unspecified',requireAccess='None']",
      logoutput => true,
    }

iis::manage_binding {$iis_site_name:
    site_name    => $iis_site_name,
    protocol     => 'https',
    port          => $iis_site_https_port,
    ip_address    => '*',
    host_header   => $iis_host_header,
    certificate_thumbprint => $iis_certificate_thumbprint 
  }

} 

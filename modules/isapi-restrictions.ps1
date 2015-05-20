Add-WebConfiguration -pspath 'MACHINE/WEBROOT/APPHOST' -filter 'system.webServer/security/isapiCgiRestriction' -value @{
          description = 'PRUN'
          path        = 'C:\inetpub\scripts\prun.dll'
          allowed     = 'True'
        }

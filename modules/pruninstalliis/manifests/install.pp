class pruninstalliis::install { 
 windowsfeature { 'IIS':
      feature_name => [
        'Web-Server',
        'Web-WebServer',
        'Web-Basic-Auth',
        'Web-Windows-Auth',
        'Web-Asp',
        'Web-Filtering',
        'Web-ISAPI-Ext',
        'Web-Mgmt-Console',
        'Web-Default-Doc',
        'Web-Dir-Browsing',
        'Web-Http-Errors',
        'Web-Http-Errors',
        'Web-Static-Content',
        'Web-Http-Logging',
      ]
    }
}

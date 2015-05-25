class prunconfiis {
    prunconfiis::createsite {'mywebsiter':
    iis_site_name => 'mywebsiter',
    iis_host_header => 'www.walla.com',
    iis_site_path => 'c:\temp',
    iis_site_http_port => '8080',
    iis_site_https_port => '8443',
    iis_certificate_thumbprint => 'cbc896e70edbe35b9b133a9c2ec1a2f5e2edaa59'
}
}

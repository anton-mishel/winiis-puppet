class prunconfiis {
   prunconfiis::createsite {'buba':
    iis_site_name => 'buba',
    iis_host_header => 'www.buba.com',
    iis_site_path => 'c:\temp',
    iis_site_http_port => '8889',
    iis_site_https_port => '8433',
    iis_certificate_thumbprint => 'cbc896e70edbe35b9b133a9c2ec1a2f5e2edaa59'
}
}

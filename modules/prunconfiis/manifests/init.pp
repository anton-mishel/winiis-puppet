class prunconfiis { 
 iis::manage_virtual_directory { ${virtual_directory_name} :
  site_name => 'Default Web Site',
  directory => ${virtual_directory_name},
  path      => ${virtual_directory_path}
 }
}

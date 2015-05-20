define pruninstallssl::install ($certificatefile,$certificatepass) 
{
 
 file { 'C:/temp':
ensure  => directory,
 }
 
file { "C:/temp/${certificatefile}":
ensure  => file,
source  => "puppet:///modules/pruninstallssl/${certificatefile}",
}

$pathprefix = 'C:/temp/'
$certificatefilepath = "${pathprefix}${certificatefile}"

 exec { "install_certificate-${certificatefile}" :
command => "\$mypwd = ConvertTo-SecureString -String ${certificatepass} -Force -AsPlainText\nImport-PfxCertificate -FilePath ${certificatefilepath} cert:\localMachine\my -Password \$mypwd",
      provider  => 'powershell',
      path      => $::path,
      logoutput => true,
    }
}

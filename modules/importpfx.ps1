function Import-PfxCertificate { 

    param([String]$certPath,[String]$certRootStore = "localmachine",[String]$certStore = "My",$pfxPass = $null) 
    $pfx = new-object System.Security.Cryptography.X509Certificates.X509Certificate2 

    if ($pfxPass -eq $null) 
    {
        $pfxPass = read-host "Password" -assecurestring
    } 

    $pfx.import($certPath,$pfxPass,"Exportable,PersistKeySet") 

    $store = new-object System.Security.Cryptography.X509Certificates.X509Store($certStore,$certRootStore) 
    $store.open("MaxAllowed") 
    $store.add($pfx) 
    $store.close() 
}

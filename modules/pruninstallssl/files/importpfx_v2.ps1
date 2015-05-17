function Install-Certificate ($certPath, [string]$storeLocation = "LocalMachine", [string]$storeName = "My")
{
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath, "", "MachineKeySet,PersistKeySet")
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, $storeLocation)
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    "Thumbprint: $($cert.Thumbprint)"
}

Install-Certificate <path-to-pfx-file>
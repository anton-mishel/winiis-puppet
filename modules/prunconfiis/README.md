#module for configuration of a website 
#Powershell commands used are: Set-WebConfigurationProperty -Filter /system.webServer/handlers -name accesspolicy -PSPath IIS:\ -Location 'Default Web Site/scripts' -Value "Read,Script,Execute"
# Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/windowsAuthentication" -Name Enabled -Value True -PSPath "IIS:\" -Location 'Default Web Site/scripts'
 
# Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name Disabled -Value True -PSPath "IIS:\" -Location 'Default Web Site/scripts'
  
# Set-WebConfigurationProperty -Filter "/system.webServer/security/authentication/anonymousAuthentication" -Name Enabled -Value False -PSPath "IIS:\" -Location 'Default Web Site/scripts'


#Add handler mapping 
# New-WebHandler -Name "PRUN" -Path "*" -ScriptProcessor "c:\inetpub\scripts\prun.dll"  -Verb '*'  -Modules "IsapiModule" -PSPath "IIS:\" -Location 'Default Web Site'


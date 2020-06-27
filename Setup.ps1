<# Unattended Install of Google Chrome #>;
$Installer = $env:TEMP + "\chrome_installer.exe"; 
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Installer; 
Start-Process -FilePath $Installer -Args "/silent /install" -Verb RunAs -Wait; 
Remove-Item $Installer;

<# Unattended Install of Oracle VirtualBox #>;
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$vBoxURL = "https://download.virtualbox.org/virtualbox";
Invoke-WebRequest -Uri "$vBoxURL/LATEST-STABLE.TXT" -OutFile "$env:TEMP\virtualbox-version.txt";
$version = ([IO.File]::ReadAllText("$env:TEMP\virtualbox-version.txt")).trim();
$vBoxList = Invoke-WebRequest "$vBoxURL/$version";
$vBoxVersion =$vBoxList.Links.innerHTML;
$vBoxFile = $vBoxVersion | select-string -Pattern "-win.exe";
$vBoxFileURL = "$vBoxURL/$version/$vBoxFile";
Invoke-WebRequest -Uri $vBoxFileURL -OutFile "$env:TEMP\$vBoxFile";
start-process ("$env:TEMP\$vBoxFile") --silent;

<# Restart Computer #>;
Restart-Computer;

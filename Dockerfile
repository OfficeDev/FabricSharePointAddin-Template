FROM microsoft/aspnet:4.6.2
RUN powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    $cert = New-SelfSignedCertificate -DnsName localhost -CertStoreLocation cert:\LocalMachine\My; \
    $certHash = $cert.GetCertHash(); \
    $sm = Get-IISServerManager; \
    $sm.Sites[\"Default Web Site\"].Bindings.Add(\"*:443:\", $certHash, \"My\", \"0\"); \
    $sm.CommitChanges(); \
    Remove-Item C:\inetpub\wwwroot\iisstart.*
ADD FabricSharePointAddin/ C:/inetpub/wwwroot/
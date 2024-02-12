try {
    $searchValue = $dataSource.searchUser

    Write-Verbose "Creating authorization headers"
    # Create authorization headers with TOPdesk API key
    $pair = "${topdeskApiUsername}:${topdeskApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{
        "authorization" = $Key
        "Accept"        = "application/json"
    }
    
    if ([String]::IsNullOrEmpty($searchValue) -eq $true) {
        return
    }
    else {
        Write-Information "searchValue: $searchValue"

        $splatParams = @{
            Uri         = "$($topdeskBaseUrl)/tas/api/persons?page_size=2&query=employeeNumber=sw=$searchValue,surName=sw=$searchValue,firstName=sw=$searchValue,email=sw=$searchValue,networkLoginName=sw=$searchValue"
            Method      = 'GET'
            Verbose     = $false
            Headers     = $Headers
            ContentType = "application/json; charset=utf-8"
        }
        $users = Invoke-RestMethod @splatParams
                
        $users = $users | Sort-Object -Property dynamicName
        $resultCount = @($users).Count
        Write-Information "Result count: $resultCount"
         
        if ($resultCount -gt 0) {
            foreach ($user in $users) {
                $returnObject = @{
                    dynamicName      = $user.dynamicName;
                    employeeNumber   = $user.employeeNumber;
                    email            = $user.email;
                    networkLoginName = $user.networkLoginName;
                    title            = $user.title;
                }
                
                Write-Output $returnObject
            }
        }
    }
}
catch {
    $msg = "Error searching Topdesk person [$searchValue]. Error: $($_.Exception.Message)"
    Write-Error $msg
}
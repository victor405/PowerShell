<#
    Author  : Victor Mendoza
    Version : 1
    Date    : 7/14/2020
#>

[CmdletBinding()]
Param
(
    [ValidateRange(10,1000)]
    [int]$Length = 20,

    [string]$Exclude,

    [switch]$NoRepeat
)
    
Begin
{
    $charPool, $password = [System.Collections.ArrayList]@(), [System.Collections.ArrayList]@()
    $characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-_=+"

    if ($exclude)
    {
        $excludeArray = $exclude.ToCharArray() | Sort-Object -Unique
            
        foreach ($char in $characters.ToCharArray())
        {
            if (!($excludeArray | Where-Object { $_ -like "*$char*" }))
            {
                $charPool.Add($char) | Out-Null
            }
        }
    }
    else
    {
        foreach ($char in $characters.ToCharArray())
        {
            $charPool.Add($char) | Out-Null
        }        
    }
}
Process
{
    try
    {            
        if ($charPool.Count -lt 2)
        {
            return "No Complex Result Possible"
        }
        else
        {
            for ($i = 0; $i -lt $length; $i++)
            {
                do
                {
                    $currentChar = ($charPool | Get-Random)
                } while ($noRepeat -and $i -gt 0 -and $isLastChar -eq $currentChar)
                $password.Add($currentChar) | Out-Null
                $isLastChar = $currentChar
            }

            return ($password -join(""))
        }
    }
    catch
    {
        Write-Error ""
    }
}
End
{
    $charPool.Clear()
}
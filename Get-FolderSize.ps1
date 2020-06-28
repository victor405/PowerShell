function Get-FolderSize
{
    <#
        Author  : Victor Mendoza
        Date    : 6/28/2020
        Version : 1
    #>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string[]]$Paths,

        [Parameter(Mandatory=$false)]
        [switch]$GB
    )

    Begin
    {
    }
    Process
    {
      foreach ($path in $paths)
      {
          $isFolder = Test-Path -Path $path

          if ($isFolder)
          {
            $size = ((Get-ChildItem -Path $path -Recurse -Force) `
            | ForEach-Object { $_.length } `
            | Measure-Object -Sum).Sum

            if ($GB)
            {
                $result = ("{0:N2}" -f ($size/1GB)) + " GB"
            }
            else
            {
                $result = $size
            }

            Write-Host -Object "$path | $result"

          }
          else
          {
            Write-Warning -Message "Folder $path does not exist."
            return
          }
        }
    }
    End
    {
    }
}
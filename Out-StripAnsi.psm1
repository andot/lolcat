#### lolcat for powershell
#### Author Ma Bingyao

function Out-StripAnsi {
    <#
    .SYNOPSIS
    Usage: Out-StripAnsi
    .EXAMPLE
    Get-ChildItem | Out-String -Stream | Out-StripAnsi
    .PARAMETER InputObject
    PipeLine input, it must be a strings
    #>
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        $InputObject
    )
    BEGIN {
        $Pattern = "[\u001B\u009B][[\]()#;?]*(?:(?:(?:[a-zA-Z\d]*(?:;[a-zA-Z\d]*)*)?\u0007)|(?:(?:\d{1,4}(?:;\d{0,4})*)?[\dA-PR-TZcf-ntqry=><~]))";
    }
    PROCESS {
        if ($InputObject -isnot [string]) {
            $InputObject = $InputObject.ToString();
        }
        if ($InputObject.Length -eq 0) {
            ""
        }
        else {
            $InputObject -replace $Pattern, ""
        }
    }
    END {
    }
}

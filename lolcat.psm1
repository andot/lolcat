#### lolcat for powershell
#### Author Ma Bingyao

function lolcat {
    <#
    .SYNOPSIS
    Usage: lolcat [FILE] [OPTION]...
    .EXAMPLE
    lolcat README
    .EXAMPLE
    Get-Process | lolcat
    .PARAMETER Path
    Input file
    .PARAMETER Spread
    Rainbow spread
    .PARAMETER Freq
    Rainbow frequency
    .PARAMETER Seed
    Rainbow seed, 0 = random
    .PARAMETER Animate
    Enable psychedelics
    .PARAMETER Duration
    Animation duration
    .PARAMETER Speed
    Animation speed
    #>
    param(
        [string]$Path,
        [Alias('p')]
        [double]$Spread = 3.0,
        [Alias('f')]
        [double]$Freq = 0.1,
        [Alias('i')]
        [int32]$Seed = 0,
        [Alias('a')]
        [switch]$Animate,
        [Alias('d')]
        [int32]$Duration = 12,
        [Alias('s')]
        [double]$Speed = 20.0
    )
    $null = $PSBoundParameters.Remove('Path');
    if ($Path) {
        Get-Content $Path -Encoding UTF8 | Out-Rainbow @PSBoundParameters
        return
    }
    $Data = @($Input)
    if ($Data.Length -eq 0) {
        $Data = @("
Usage: lolcat [FILE] [OPTION]...

    -spread, -p <f>:   Rainbow spread (default: 3.0)
      -freq, -f <f>:   Rainbow frequency (default: 0.1)
      -seed, -i <i>:   Rainbow seed, 0 = random (default: 0)
       -animate, -a:   Enable psychedelics
  -duration, -d <i>:   Animation duration (default: 12)
     -speed, -s <f>:   Animation speed (default: 20.0)

Examples:
  lolcat          Show this message.
  lolcat README   Display a rainbow README.
  dir | lolcat    Display a rainbow directory list.");
        $PSBoundParameters['Spread'] = 8.0;
        $PSBoundParameters['Freq'] = 0.3;
    }
    $Data | Out-String -Stream | Out-Rainbow @PSBoundParameters
}

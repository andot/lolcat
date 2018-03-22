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
    .PARAMETER Version
    Print Version and exit
    .PARAMETER Help
    Show this message
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
        [double]$Speed = 20.0,
        [Alias('v')]
        [switch]$Version,
        [Alias('h')]
        [switch]$Help
        
    )
    $null = $PSBoundParameters.Remove('Path');
    $null = $PSBoundParameters.Remove('Version');
    $null = $PSBoundParameters.Remove('Help');
    if ($Version) {
        Write-Host "lolcat 1.0.0 (c)2018 andot@hprose.com"
        return
    }
    if ($Path) {
        Get-Content $Path -Encoding UTF8 | Out-Rainbow @PSBoundParameters
        return
    }
    $Data = @($Input)
    if ($Help -or ($Data.Length -eq 0)) {
        $Data = @("
Usage: lolcat [FILE] [OPTION]...

    -spread, -p <f>:   Rainbow spread (default: 3.0)
      -freq, -f <f>:   Rainbow frequency (default: 0.1)
      -seed, -i <i>:   Rainbow seed, 0 = random (default: 0)
       -animate, -a:   Enable psychedelics
  -duration, -d <i>:   Animation duration (default: 12)
     -speed, -s <f>:   Animation speed (default: 20.0)
       -version, -v:   Print version and exit
          -help, -h:   Show this message

Examples:
  lolcat          Show this message.
  lolcat README   Display a rainbow README.
  dir | lolcat    Display a rainbow directory list.

Report lolcat bugs to <https://www.github.com/andot/lolcat/issues>
lolcat home page: <https://www.github.com/andot/lolcat/>
Report lolcat translation bugs to <http://speaklolcat.com/>
");
        $PSBoundParameters['Spread'] = 8.0;
        $PSBoundParameters['Freq'] = 0.3;
    }
    $Data | Out-String -Stream | Out-Rainbow @PSBoundParameters
}

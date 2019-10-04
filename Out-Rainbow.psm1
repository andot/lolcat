#### lolcat for powershell
#### Author Ma Bingyao

function Out-Rainbow {
    <#
    .SYNOPSIS
    Usage: Out-Rainbow [OPTION]...
    .EXAMPLE
    Out-Rainbow README
    .EXAMPLE
    Get-Process | Out-String -Stream | Out-Rainbow
    .PARAMETER InputObject
    PipeLine input, it must be a strings
    .PARAMETER Spread
    Rainbow Spread
    .PARAMETER freq
    Rainbow frequency
    .PARAMETER Seed
    Rainbow Seed, 0 = random
    .PARAMETER Animate
    Enable psychedelics
    .PARAMETER Duration
    Animation duration
    .PARAMETER Speed
    Animation speed
    #>
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        $InputObject,
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
    BEGIN {
        $ESC = [char]27;
        if ($Seed -eq 0) {
            $Seed = Get-Random -max 255;
        }
        if ($MyInvocation.PipelinePosition -ne $MyInvocation.PipelineLength) {
            $Animate = $False;
        }
        if ($Animate) {
            [Console]::Write("$ESC[?25l");
        }
        else {
            $Duration = 1;
        }
    }
    PROCESS {
        if ($InputObject -isnot [string]) {
            $InputObject = $InputObject.ToString();
        }
        if ($InputObject.Length -eq 0) {
            if ($Animate) {
                [Console]::WriteLine();
            }
            else {
                Write-Output ""
            }
            return;
        }
        $ENTER = [char]13;
        $NEWLINE = [char]10;
        [char[]] $Separators = $NEWLINE;
        $Lines = $InputObject.TrimEnd($ENTER, $NEWLINE).Replace("$ENTER$NEWLINE", "$NEWLINE").Replace($ENTER, $NEWLINE).Split($Separators, [StringSplitOptions]::None);
        foreach ($Line in $Lines) {
            $Seed++;
            $Length = $Line.Length;
            $Out = "";
            if ($Length -gt 0) {
                $s = $Seed;
                for ($x = 1; $x -le $Duration; $x++) {
                    $Out = "";
                    if ($x -lt $Duration) {
                        $Out += "$ESC[s";
                    }
                    if ($Animate) {
                        $s+=$Spread;
                    }
                    for ($i = 0; $i -lt $Length; $i++) {
                        $n = ($s+$i/$Spread);
                        $c = $Line[$i];
                        if ([Char]::IsSurrogatePair($c, $Line[$i+1])) {
                            $c = $c + $Line[$i+1];
                            $i++;
                        }
                        $Red   = [int]([Math]::Sin($Freq*$n + 0)*127 + 128);
                        $Green = [int]([Math]::Sin($Freq*$n + 2*[Math]::PI/3)*127 + 128);
                        $Blue  = [int]([Math]::Sin($Freq*$n + 4*[Math]::PI/3)*127 + 128);
                        $Out += "$ESC[38;2;$Red;$Green;$Blue;1m$c$ESC[0m";
                    }
                    if ($x -lt $Duration) {
                        $Out += "$ESC[u"
                    }
                    if ($Animate) {
                        [Console]::Write($Out)
                        Start-Sleep -Milliseconds ([int](1000/$Speed))
                    }
                }
            }
            if ($Animate) {
                [Console]::WriteLine()
            }
            else {
                Write-Output $Out
            }
        }
    }
    END {
        if ($Animate) {
            [Console]::Write("$ESC[?25h");
        }
    }
}

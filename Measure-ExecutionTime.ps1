Param(
    [System.IO.FileInfo[]] $TestFiles,
    [System.IO.FileInfo] $CoreRoot,
    [System.IO.FileInfo] $Env,
    [int] $Samples = 5,
    [switch] $Silent = $false
)

function Measure-Average([ScriptBlock] $Expression, [int] $Samples) {
    $times = @()

    for ($i = 0; $i -lt $Samples; $i++) {

        if ($Silent) {
            "ITERATION $($i)" | Out-Default
            $time = Measure-Command { & $Expression }
        } else {
            ""                               | Out-Default
            "OUTPUT BEGIN - ITERATION $($i)" | Out-Default

            $time = Measure-Command { & $Expression | Out-Default }

            ""                             | Out-Default
            "OUTPUT END - ITERATION $($i)" | Out-Default
        }
        $times += $time
    }

    $times | Measure-Object -Average -Minimum -Maximum -Property TotalMilliseconds
}

function Print-Stats($Stats, [string] $Prefix) {
    "$($Prefix): Average $($Stats.Average) ms, Minimum $($Stats.Minimum) ms, Maximum $($Stats.Maximum) ms"
}

$TestFiles | % {
    "================================================================================"
    "Test File: $($_)"

    $config = "Default Configuration"

    ""
    "$($config)"
    $testFile = [System.IO.Path]::Combine($_.DirectoryName, $_.Name)
    $env      = [System.IO.Path]::Combine($Env.DirectoryName, $Env.Name)

    $expression = [ScriptBlock]::Create("$($testFile) -coreroot $($CoreRoot.DirectoryName) -env $($env)")

    $stats = Measure-Average -Expression $expression -Samples $Samples
    
    ""
    Print-Stats $stats $config | Out-Default
}

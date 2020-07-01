$TestFiles = @("C:\Users\t-yucpan\GitHub\runtime\artifacts\tests\coreclr\Windows_NT.x64.Checked\JIT\Performance\CodeQuality\Linq\Linq\Linq.cmd",
               "C:\Users\t-yucpan\GitHub\runtime\artifacts\tests\coreclr\Windows_NT.x64.Checked\JIT\Performance\CodeQuality\SciMark\SciMark\SciMark.cmd")
$CoreRoot  = "C:\Users\t-yucpan\GitHub\runtime\artifacts\tests\coreclr\Windows_NT.x64.Debug\Tests\Core_Root\"
$Env       = "C:\Users\t-yucpan\GitHub\InterpTest\env.cmd"
$Samples   = 2
$Silent    = $true

.\Measure-ExecutionTime -TestFiles $TestFiles -CoreRoot $CoreRoot -Env $Env -Samples $Samples -Silent $Silent
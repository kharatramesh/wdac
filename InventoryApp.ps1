<#
.SYNOPSIS
  Contoso Inventory: a simple console app written as a PowerShell script (WDAC lab sample).
#>

$mode = $ExecutionContext.SessionState.LanguageMode
Write-Host "=== Contoso Inventory ===" -ForegroundColor Cyan
Write-Host "Language mode: $mode"

$items = @(
    [pscustomobject]@{ Sku = 'C-1001'; Name = 'Laptop';  Qty = 12; Price = 950 }
    [pscustomobject]@{ Sku = 'C-1002'; Name = 'Monitor'; Qty = 30; Price = 210 }
    [pscustomobject]@{ Sku = 'C-1003'; Name = 'Keyboard'; Qty = 75; Price = 35 }
)
$items | Format-Table -AutoSize

$total = ($items | ForEach-Object { $_.Qty * $_.Price } | Measure-Object -Sum).Sum
Write-Host "Total stock value: $total"

# A .NET call outside the allowed core types: works in FullLanguage, fails in ConstrainedLanguage
try {
    $hostName = [System.Net.Dns]::GetHostName()
    Write-Host "Report generated on $hostName" -ForegroundColor Green
} catch {
    Write-Host "Blocked by Constrained Language Mode: $($_.Exception.Message)" -ForegroundColor Red
}

<#
.SYNOPSIS
  Fabrikam Notes: a simple GUI notes app written as a PowerShell script (WDAC lab sample).
#>

$mode = $ExecutionContext.SessionState.LanguageMode
Write-Host "Fabrikam Notes - language mode: $mode"

# Add-Type and WinForms are not allowed in Constrained Language Mode, so the window only opens in FullLanguage
try {
    Add-Type -AssemblyName System.Windows.Forms
} catch {
    Write-Host "Blocked by Constrained Language Mode: $($_.Exception.Message)" -ForegroundColor Red
    return
}

$notesFile = Join-Path $env:TEMP 'FabrikamNotes.txt'

$form = New-Object System.Windows.Forms.Form
$form.Text = "Fabrikam Notes ($mode)"
$form.Size = New-Object System.Drawing.Size(500, 400)

$box = New-Object System.Windows.Forms.TextBox
$box.Multiline = $true
$box.ScrollBars = 'Vertical'
$box.Dock = 'Fill'
if (Test-Path $notesFile) { $box.Text = Get-Content $notesFile -Raw }

$save = New-Object System.Windows.Forms.Button
$save.Text = 'Save'
$save.Dock = 'Bottom'
$save.Add_Click({ Set-Content -Path $notesFile -Value $box.Text; $form.Text = "Fabrikam Notes - saved" })

$form.Controls.Add($box)
$form.Controls.Add($save)
[void]$form.ShowDialog()

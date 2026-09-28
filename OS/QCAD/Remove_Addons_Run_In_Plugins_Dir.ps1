$files = @(
    'qcadcavalier.dll', 'qcadpdf.dll', 'qcadpolygon.dll', 'qcadproj.dll',
    'qcadproscripts.dll', 'qcadproxies.dll', 'qcadshp.dll',
    'qcadspatialindexpro.dll', 'qcadtrace.dll', 'qcaddwg.dll'
)

foreach ($f in $files) {
    $path = Join-Path $PSScriptRoot $f
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "Deleted $f"
    } else {
        Write-Host "Not found: $f"
    }
}
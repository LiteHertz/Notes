# Creates subfolders called PDF and SRC in the end most subfolders. How to use : .\PDF_SRC_SUBFOLDERS.ps1 -Path "C:\Your\Root\Folder"

<#
.SYNOPSIS
    Adds "SRC" and "PDF" subfolders inside every "leaf" folder (a folder with no
    subfolders of its own) found under a given root path.

.PARAMETER Path
    The root folder to scan.

.PARAMETER WhatIf
    Preview which folders would be created, without actually creating them.

.EXAMPLE
    .\Add-SrcPdfFolders.ps1 -Path "D:\Projects"

.EXAMPLE
    .\Add-SrcPdfFolders.ps1 -Path "D:\Projects" -WhatIf
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Path,

    [switch]$WhatIf
)

if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
    Write-Error "Path not found or not a folder: $Path"
    exit 1
}

# Get every subfolder under the root (not the root itself)
$allFolders = Get-ChildItem -LiteralPath $Path -Recurse -Directory

if ($allFolders.Count -eq 0) {
    Write-Warning "No subfolders found under $Path"
    exit 0
}

# A "leaf" folder is one that has no subfolders of its own.
# We compute this BEFORE creating anything, so newly added SRC/PDF
# folders don't get treated as leaves themselves.
$leafFolders = $allFolders | Where-Object {
    (Get-ChildItem -LiteralPath $_.FullName -Directory -ErrorAction SilentlyContinue).Count -eq 0
}

Write-Host "Found $($leafFolders.Count) leaf folder(s) under '$Path'." -ForegroundColor Cyan

foreach ($folder in $leafFolders) {
    foreach ($sub in @("SRC", "PDF")) {
        $target = Join-Path -Path $folder.FullName -ChildPath $sub

        if (Test-Path -LiteralPath $target) {
            Write-Host "Already exists: $target" -ForegroundColor DarkGray
            continue
        }

        if ($WhatIf) {
            Write-Host "Would create: $target" -ForegroundColor Yellow
        }
        else {
            New-Item -Path $target -ItemType Directory | Out-Null
            Write-Host "Created: $target" -ForegroundColor Green
        }
    }
}

Write-Host "Done." -ForegroundColor Cyan
# PowerShell script to upload the project to GitHub
$repoUrl = "https://github.com/srinivasarao3234/springboot.git"

Write-Host "--- Initializing Git Repository ---" -ForegroundColor Cyan

# Check if git is initialized
if (!(Test-Path .git)) {
    git init
}

# Add all files
git add .

# Commit
git commit -m "Initial commit: Library Management System with CRUD and Join View"

# Rename branch to main
git branch -M main

# Add remote
git remote remove origin 2>$null
git remote add origin $repoUrl

Write-Host "`n--- Pushing to GitHub ---" -ForegroundColor Cyan
Write-Host "Note: A login window may appear. Please log in to your GitHub account." -ForegroundColor Yellow

git push -u origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSUCCESS: Project uploaded successfully to $repoUrl" -ForegroundColor Green
} else {
    Write-Host "`nERROR: Failed to push to GitHub. Please check your internet connection or GitHub permissions." -ForegroundColor Red
}

Write-Host "`nPress any key to close..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

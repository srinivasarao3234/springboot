# Run this script to copy screenshots to the docs folder
$srcDir = "C:\Users\siddu\.gemini\antigravity\brain\7d251487-3cd6-42c5-b4b4-249474df24c5"
$dstDir = "c:\Users\siddu\OneDrive\Desktop\BDA-SGA\docs\screenshots"

New-Item -ItemType Directory -Path $dstDir -Force | Out-Null

Copy-Item "$srcDir\home_page_1777710737792.png" "$dstDir\home_page.png" -Force
Copy-Item "$srcDir\authors_list_1777710764507.png" "$dstDir\authors_list.png" -Force
Copy-Item "$srcDir\author_form_1777710780751.png" "$dstDir\author_form.png" -Force
Copy-Item "$srcDir\books_list_1777710808042.png" "$dstDir\books_list.png" -Force
Copy-Item "$srcDir\join_view_1777710824067.png" "$dstDir\join_view.png" -Force
Copy-Item "$srcDir\test_results_1777710841525.png" "$dstDir\test_results.png" -Force

Write-Host "All screenshots copied to $dstDir"

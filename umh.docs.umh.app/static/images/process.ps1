$rootDir = Invoke-Expression "git rev-parse --show-toplevel"

# Goto rootDir\static\images
$dir = Join-Path $rootDir "\mgmt.docs.umh.app\static\images"
Set-Location $dir

# For each image in the directory (recursive) (.png, .jpg, .jpeg, .bmp, .tiff, .tif)

# Get all the image files in the directory and its subdirectories
$imageFiles = Get-ChildItem -Path $dir -Recurse -Include *.png, *.jpg, *.jpeg, *.bmp, *.tiff, *.tif

Write-Host "Converting $($imageFiles.Count) images to AVIF and WebP"

# Loop over each image file and execute cavif on it
foreach ($file in $imageFiles) {
    # If cavif.exe is installed, execute it on the image
    if (Get-Command cavif.exe -ErrorAction SilentlyContinue) {
        # replace image extension with .avif
        $avifFile = $file.FullName -replace "\.[^.]+$", ".avif"
        cavif.exe -f $file.FullName -o $avifFile
    }

    # If cwebp.exe is installed, execute it on the image
    if (Get-Command cwebp.exe -ErrorAction SilentlyContinue) {
        # replace image extension with .webp
        $webpFile = $file.FullName -replace "\.[^.]+$", ".webp"
        cwebp.exe -mt -q 100 $file.FullName -o $webpFile
    }
}

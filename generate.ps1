# edit the following variables
# Note: for paths on Windows, don't include drive letter (e.g. use '\Temp', not 'C:\Temp')

# base file name (without extension) of Android icon files (usually 'ic_launcher') 
$android_icon_name = ""

# full path to the Android app directory
$android_app_dir = ""

# base file name (without extension) of iOS icon asset catalog directory
$ios_icon_assetcatalog_name = ""

# base file name (without dimensions and extension) of iOS icon files (both typically 'AppIcon') 
$ios_icon_name = ""

# full path to the iOS app directory
$ios_app_dir = ""

# source icons (SVG) base file names (without extension)
$android_source_adaptive_icon_basename = ""
$android_source_legacy_icon_basename = ""
$android_source_store_icon_basename = ""

$ios_source_icon_basename = ""

# Create temp directory
# Inkscape has problems with colons in paths
$system_temp_path = $([System.IO.Path]::GetTempPath() -replace '^[A-Z]:', '')
$temp_dir = "${system_temp_path}app-icon-generator-$(New-Guid)"
New-Item -Type Directory ${temp_dir} | Out-Null

$android_icon_margin = 18
$android_res_dir = "${android_app_dir}/src/main/res"

# convert icon to Android Vector XML adaptive icon foregroundc
"
file-open: ${android_source_adaptive_icon_basename}.svg
select-all
export-margin: ${android_icon_margin}
export-plain-svg; export-filename: ${temp_dir}/${android_source_adaptive_icon_basename}.svg
export-do
" | inkscape --shell 2>&1 | Out-Null
java -jar Svg2VectorAndroid-1.0.1.jar ${temp_dir}
Copy-Item "${temp_dir}/ProcessedSVG/${android_source_adaptive_icon_basename}_svg.xml" "${android_res_dir}/drawable/${android_icon_name}_foreground.xml"

# create Android legacy icon dirs
mkdir -Force `
    ${android_res_dir}/mipmap-mdpi,
    ${android_res_dir}/mipmap-hdpi,
    ${android_res_dir}/mipmap-xhdpi,
    ${android_res_dir}/mipmap-xxhdpi,
    ${android_res_dir}/mipmap-xxxhdpi
| Out-Null

"
export-type:png; 
file-open:${android_source_legacy_icon_basename}.svg

export-width:48; export-filename:${android_res_dir}/mipmap-mdpi/${android_icon_name}.png; export-do
export-width:72; export-filename:${android_res_dir}/mipmap-hdpi/${android_icon_name}.png; export-do
export-width:96; export-filename:${android_res_dir}/mipmap-xhdpi/${android_icon_name}.png; export-do
export-width:144; export-filename:${android_res_dir}/mipmap-xxhdpi/${android_icon_name}.png; export-do
export-width:192; export-filename:${android_res_dir}/mipmap-xxxhdpi/${android_icon_name}.png; export-do

file-open:${android_source_store_icon_basename}.svg
export-width:512; export-filename:${android_app_dir}/src/main/${android_icon_name}-playstore.png; export-do
" | inkscape --shell 2>&1 | Out-Null


$ios_icon_dir = "${ios_app_dir}/Assets.xcassets/${ios_icon_assetcatalog_name}.appiconset"
"
export-type:png; 
file-open: ${ios_source_icon_basename}.svg

export-width:20; export-filename:${ios_icon_dir}/${ios_icon_name}-20x20@1x.png; export-do
export-width:40; export-filename:${ios_icon_dir}/${ios_icon_name}-20x20@2x.png; export-do
export-width:60; export-filename:${ios_icon_dir}/${ios_icon_name}-20x20@3x.png; export-do
export-width:29; export-filename:${ios_icon_dir}/${ios_icon_name}-29x29@1x.png; export-do
export-width:58; export-filename:${ios_icon_dir}/${ios_icon_name}-29x29@2x.png; export-do
export-width:87; export-filename:${ios_icon_dir}/${ios_icon_name}-29x29@3x.png; export-do
export-width:40; export-filename:${ios_icon_dir}/${ios_icon_name}-40x40@1x.png; export-do
export-width:80; export-filename:${ios_icon_dir}/${ios_icon_name}-40x40@2x.png; export-do
export-width:120; export-filename:${ios_icon_dir}/${ios_icon_name}-40x40@3x.png; export-do
export-width:50; export-filename:${ios_icon_dir}/${ios_icon_name}-50x50@1x.png; export-do
export-width:100; export-filename:${ios_icon_dir}/${ios_icon_name}-50x50@2x.png; export-do
export-width:57; export-filename:${ios_icon_dir}/${ios_icon_name}-57x57@1x.png; export-do
export-width:114; export-filename:${ios_icon_dir}/${ios_icon_name}-57x57@2x.png; export-do
export-width:60; export-filename:${ios_icon_dir}/${ios_icon_name}-60x60@1x.png; export-do
export-width:120; export-filename:${ios_icon_dir}/${ios_icon_name}-60x60@2x.png; export-do
export-width:72; export-filename:${ios_icon_dir}/${ios_icon_name}-72x72@1x.png; export-do
export-width:144; export-filename:${ios_icon_dir}/${ios_icon_name}-72x72@2x.png; export-do
export-width:76; export-filename:${ios_icon_dir}/${ios_icon_name}-76x76@1x.png; export-do
export-width:152; export-filename:${ios_icon_dir}/${ios_icon_name}-76x76@2x.png; export-do
export-width:167; export-filename:${ios_icon_dir}/${ios_icon_name}-83.5x83.5@2x.png; export-do
export-width:1024; export-filename:${ios_icon_dir}/${ios_icon_name}-1024x1024@1x.png; export-do

" | inkscape --shell 2>&1 | Out-Null

# remove temp dir
Remove-Item -Recurse -Force ${temp_dir} -ErrorAction SilentlyContinue

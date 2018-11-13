# Help output
if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]; then cat <<EOF
Darwin Icon Converter for macOS
Part of the Darwin-Scripts toolset <https://github.com/snem1216/Darwin-Scripts>
Bidirectionally converts PNG iconsets and ICNS files.
Usage: bash dariconvert.sh <iconset_or_icns_to_convert>
Conversion type will be determined automatically. Output files appear in same directory.
Files must have a 1:1 aspect ratio or conversion will fail.
Copyright 2018 Steve Nemeti <https://github.com/snem1216>
EOF
exit; fi

input_type=$(file $1)
# ICNS to ICONSET
if [[ $input_type = *"Mac OS X icon"* ]]; then
  base_name=$(basename $1 ".icns")
  output_directory=$(dirname $1)
  iconutil --convert iconset $1 --output $output_directory/$base_name.iconset
  echo Result: $output_directory/$base_name.iconset

# ICONSET TO ICNS
else if [[ $input_type = *"directory"* ]]; then
  base_name=$(basename $1 ".iconset")
  output_directory=$(dirname $1)
  iconutil --convert icns $1 --output $output_directory/$base_name.icns
  echo Result: $output_directory/$base_name.icns

# Bad input
else echo ERROR: No valid input files detected.
fi
fi

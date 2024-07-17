#!/bin/bash

directory=$(pwd)

if [[ ! -d "$directory" ]]; then
  echo "The specified directory does not exist."
  exit 1
fi

total_size=0
file_count=0
largest_file=""
largest_size=0
smallest_file=""
smallest_size=0
threshold_size=0

read -p "Enter a size threshold (in bytes) to list files exceeding that size (or press Enter to skip): " threshold_size

for file in "$directory"/*; do
  if [[ -f "$file" ]]; then
    file_size=$(stat -c%s "$file")
    total_size=$((total_size + file_size))
    file_count=$((file_count + 1))


    if [[ $file_size -gt $largest_size ]]; then
      largest_size=$file_size
      largest_file=$file
    fi


    if [[ $smallest_size -eq 0 ]] || [[ $file_size -lt $smallest_size ]]; then
      smallest_size=$file_size
      smallest_file=$file
    fi
  fi
done


if [[ $file_count -ne 0 ]]; then
  average_size=$((total_size / file_count))
else
  average_size=0
fi


echo "Summary Report for Directory: $directory"
echo "---------------------------------------"
echo "Total size of all files: $total_size bytes"
echo "Average file size: $average_size bytes"
echo "Largest file: $largest_file ($largest_size bytes)"
echo "Smallest file: $smallest_file ($smallest_size bytes)"


if [[ $threshold_size -ne 0 ]]; then
  echo "Files exceeding $threshold_size bytes:"
  for file in "$directory"/*; do
    if [[ -f "$file" ]]; then
      file_size=$(stat -c%s "$file")
      if [[ $file_size -gt $threshold_size ]]; then
        echo "$file ($file_size bytes)"
      fi
    fi
  done
fi
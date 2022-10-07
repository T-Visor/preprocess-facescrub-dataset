#!/bin/sh

# Convert all images in this dataset from '.jpeg' to '.jpg'.
for d in ./*/ ; do (cd "$d" && mogrify -format jpg *.jpeg); done

# Remove the old '.jpeg' files.
for d in ./*/ ; do (cd "$d" && rm *.jpeg); done

# Remove redundant files from Lowkey preprocessed dataset.
find . -type f ! -name '*_attacked.png' -delete

# Remove redundant files from Fawkes preprocessed dataset.
find . -type f ! -name '*_cloaked.png' -delete

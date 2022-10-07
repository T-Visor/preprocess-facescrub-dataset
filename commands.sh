#!/bin/sh

# Convert all images in this dataset from '.jpeg' to '.jpg'.
for d in ./*/ ; do (cd "$d" && mogrify -format jpg *.jpeg); done

# Remove the old '.jpeg' files.
for d in ./*/ ; do (cd "$d" && rm *.jpeg); done

# Remove redundant files from Lowkey preprocessed dataset.
find . -type f ! -name '*_attacked.png' -delete

# Remove redundant files from Fawkes preprocessed dataset.
find . -type f ! -name '*_cloaked.png' -delete

# Convert files preprocessed with Lowkey back to their original names.
# PRECONDITION: files have been converted from png to jpg with mogrify.
find . -depth -name "*.jpg" -exec sh -c 'f="{}"; mv -- "$f" "${f%_attacked.jpg}.jpg"' \;

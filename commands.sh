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

# For creating train/test data on a set of files
https://stackoverflow.com/questions/53074712/how-to-split-folder-of-images-into-test-training-validation-sets-with-stratified

# For moving files in subdirectories into the main directory
# https://superuser.com/questions/355891/move-all-files-from-subdirectories-to-current-directory
find . -type f -mindepth 2 -exec mv -i -- {} . \; && find . -depth -mindepth 1 -type d -empty -exec rmdir {} \;



###################################################################################################
# Dealing with results from cyclegan and pix2pix repository
###################################################################################################

# NOTE: change 'lowkey_to_original' to the corresponding immediate subdirectory
# Move all generated images back 3 directories
for d in ./*/ ; do (cd "$d/lowkey_to_original/test_latest/images" && mv *.png ../../..) ; done

# Remove all remaining subdirectories
for d in ./*/ ; do (cd "$d" && rm -rf lowkey_to_original) ; done

# Remove all the original images from the image-to-image translation and only keep the generated images.
for d in ./*/ ; do (cd "$d" && rm *_real.png) ; done

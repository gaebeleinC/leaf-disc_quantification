# leaf-disc_quantification
Matlab-based package to analyse leaf discs in 96 well plates

Script package for automatic evaluation of Leaf-Disc
assays via Matlab 2023-03-20


Running the script:
Create a folder holding all your images of 96 well plates containing the
leaf discs. Ideally, the images do not contain any other objects except for
the well plate.
Run the script, ‘leaf_disc_segmentation’

Currently, the script is running only with .jpg files. If you want to use
another file format use change the format name in line 23 from jpg to a
format of choice. Only formats recognized by the ‘imread’ function from
Matlab will be allowed

For scaling, click on two marker points on the well plate. The points used
for the current version are shown in the additional image in the main
branch. The two chosen points are approximately 70mm apart. If you
want to choose other landmarks for scaling, measure their distance on
the plate and enter it in the subscript ‘leaf_scaling’ in line 4
The script creates a results folder containing sanity control images and
output tables as .xls to be analysed downstream
The package includes two versions:
the ‘batch-processing’ version: The first image is used to scale all
images within the folder
And the ‘single-processing’ version: All images within the folders will
be scaled individually

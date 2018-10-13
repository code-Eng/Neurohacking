"This script is about how to convert the dicom to 
nifti file "
# add the library frist 
library(oro.dicom)
library(oro.nifti)
# change the working directory
setwd('~/githubfiles/Neurohacking/Neurohacking_data/BRAINIX/DICOM')
# read all the slices
all_slices_T1 = readDICOM('T1/')

dim(all_slices_T1$img[[1]])

hdr=all_slices_T1$hdr[[1]]
hdr[hdr$name == "PixelSpacing", "value"]

# after having all the slice, convert it to NIFTI
nii_T1=dicom2nifti(all_slices_T1)
d=dim(nii_T1); d; class(nii_T1)
image(1:d[1], 1:d[1], nii_T1[,,11], 
      col = gray(0:64/64),
      xlab = '',
      ylab = '')
"Know using package oro.nifti, we can writeNIFTI
readNIFTI 
by default for NIFTI is compressed 
"
setwd('/Users/alhussainalmarhabi/githubfiles/Neurohacking/Neurohacking_data/BRAINIX/NIfTI')
#write the name of output file
fname = "Al_Output_3D_File"
# write the NIFIT file
writeNIfTI(nim = nii_T1, filename = fname)
# using list.files we check if nifti file is created
list.files(getwd(), pattern = "Al_Output_3D_File.nii.gz")
# check other file we already have
list.files(getwd(), pattern = "T")
# Know lets read NIfTI file
nii_T2=readNIfTI("T2.nii.gz", reorient = FALSE); 
dim(nii_T2)
# we can still use same d for T1
# here we plotting 11 slice of the nifti, half way
# plotting all the 22 give us unclear image
image(1:d[1], 1:d[1], nii_T2[,,11], 
      col = gray(0:64/64),
      xlab = '',
      ylab = '')

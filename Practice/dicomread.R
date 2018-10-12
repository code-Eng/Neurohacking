# practice for Neurohacking course 


"This files is about how to read DICOM sturctual MRI file.
DICOM is repreastation of one slice of brain"

# import the library we need 
library(oro.dicom)
# download the data
url <- "https://raw.githubusercontent.com/muschellij2/Neurohacking_data/master/BRAINIX/DICOM/T1/IM-0001-0001.dcm"
destfile <- "IM-0001-0001.dcm"
name <- file.path(getwd(), destfile)
download.file(url, destfile,mode="wb") # DICOM is binaryfile format
slice <- readDICOM(destfile)

# taking look to image file
names(slice) # should show you list of (image and header)
class(slice$hdr) # show us the type 
dim(slice$img) # check the dimention of the matrix

"change the working directory to github file 
where the DICOM file you wnat to use
"
slice1=readDICOM('IM-0001-0001.dcm')
slice2=readDICOM('IM-0001-0002.dcm')
slice3=readDICOM('IM-0001-0003.dcm')

"This part focus on Image part pixel"
# using transpose data to plot the image 
par(mfrow = c(2,1)) # creat multiplut in on chart
d1 = dim(t(slice1$img[[1]]))
d2 = dim(t(slice$img[[1]]))
d3 = dim(t(slice3$img[[1]]))
image(1:d1[1], 1:d1[2], t(slice1$img[[1]]), 
      col = gray(0:64/64))
image(1:d2[1], 1:d2[2], t(slice2$img[[1]]), 
      col = gray(0:64/64))
image(1:d3[1], 1:d3[2], t(slice3$img[[1]]), 
      col = gray(0:64/64))

# to show small part of the image 
par(mfrow = c(1,1))
slice1$img[[1]][101:105,121:125]
hist(slice1$img[[1]][,],
     breaks = 50, xlab = 'FLAIR',
     prob =T, col = rgb(1,0,1,1/4),
     main = '')

"This part focus on the header and meta-data"
hdr = slice1$hdr[[1]]

names(hdr)

hdr$name
# This kind of show the resulotion 
hdr[hdr$name == "PixelSpacing", "value"]
# also FlipAngle is importatnt to know 
hdr[hdr$name == "FlipAngle",]

"Nonw read all the DICOM FILE"
# change the working directory
setwd('~/githubfiles/Neurohacking/Neurohacking_data/BRAINIX/DICOM')
# read all the slices
all_slices_T1 = readDICOM('T1/')

dim(all_slices_T1$img[[1]])

hdr=all_slices_T1$hdr[[1]]
hdr[hdr$name == "PixelSpacing", "value"]

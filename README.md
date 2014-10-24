#bibutils-bug

[bibutils 5.4](http://sourceforge.net/projects/bibutils/) appears to have some trouble discerning the correct document types of MOD files in conversion to .ris and some other formats

using source MOD files from the LOC MODs page I will demonstrate the failings

##Usage
run `test.sh` and it should go out and grab source files from LOC if not present
and run the transformations. You can view the doctypes of each transformation afterwards
by opening `results`

> Note: that the source files are included currently in the event that the LOC links change

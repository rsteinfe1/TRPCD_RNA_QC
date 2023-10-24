library(ggplot2)

## script to run
## RSeQC
## Please run this via bash script (e.g. run_all.sh)

input.dir = '/fh/fast/peters_u/GECCO_Working/robert_working/Projects/TRPCD_RNASeqQC/input/'

laneids = list.files(input.dir)[c(2,5,6,7,8)]


library(ggplot2)

## Wrapper to run
## RSeQC scripts
## Please run this via bash script (e.g. run_all.sh)
## To make sure all modules are loaded

input.dir = '/fh/fast/peters_u/GECCO_Working/robert_working/Projects/TRPCD_RNASeqQC/input/'
laneids = list.files(input.dir, full.names=T)[c(2,5,6,7,8)]
bamsuf = '/Analysis/STAR/BAM/'

bams = list.files(paste0(laneids, bamsuf), pattern=".bam$", full.names=T)

rseqc = paste0('/app/software/RSeQC/5.0.1-foss-2021b/bin/',
        c("tin.py", "RNA_fragment_size.py", "inner_distance.py",
          "infer_experiment.py", "junction_saturation.py",
          "read_GC.py", "RPKM_saturation.py"))

#Unfortunately, every tool needs its own config
#Source: https://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/
#Build hg38



library(ggplot2)

## Wrapper to run
## RSeQC scripts
## Please run this via bash script (e.g. run_all.sh)
## To make sure all modules are loaded (BEDTools, RSeQC)

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

#Create on first
refdir = '/fh/fast/peters_u/GECCO_Working/robert_working/Projects/TRPCD_RNASeqQC/ref/'
if(!dir.exists(refdir)){
    dir.create(refdir)
    baseurl='https://sourceforge.net/projects/rseqc/files/BED/Human_Homo_sapiens/'
    # Ref gene model bed12
    file='hg38_GENCODE.v38.bed.gz'
    url=paste0(baseurl, file)
    file=paste0(refdir, file)
    download.file(url, file)

    #Intersect the bed with target regions
    require(R.utils)
    R.utils::gunzip(file)
    file=sub(".gz", "", file)
    targets = "/fh/fast/peters_u/GECCO_Working/jeroenworking/projects/TRPCD_RNASeq/annotations/truseq-rna-exome-targeted-regions-manifest-v1-2-Hg38.bed"
    #We subset to genes that are targeted. But we take the whole gene, not just intersection
    genref = paste0(refdir, "hg38_Overlap_GENCODE.v38_TruSeq_RNA-exome_targets.bed")
    system(paste0("bedtools intersect -wa -a ", file, " -b ", targets, " | uniq > ",
     genref))
} else {
    genref = paste0(refdir, "hg38_Overlap_GENCODE.v38_TruSeq_RNA-exome_targets.bed")
}

#Run RSeQC on gizmo

#!/bin/bash
#PBS -N bam_to_bw
#PBS -o bam_to_bw.sh.out
#PBS -e bam_to_bw.sh.err
#PBS -V
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=1
#PBS -A yeo-group
#PBS -q home

# Go to the directory from which the script was called
cd $PBS_O_WORKDIR

# Argument 1 is text file where each line is the full path to an input bam
# Argument 2 is the output directory

bash /projects/ps-yeolab3/ekofman/RPS2_visualization/bigwigs/bam_to_bw.sh /projects/ps-yeolab3/ekofman/RPS2_visualization/bigwigs/bam_to_bw_inputs.txt \
/projects/ps-yeolab3/ekofman/RPS2_visualization/bigwigs \
/projects/ps-yeolab3/bay001/reference_data/hg19/hg19.chrom.sizes
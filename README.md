# BAM to bigwig
A script to make stranded bigwig files from one or more bam files. Useful for STAMP edit C calculations.

 These steps can take a while, so update the qsub_bam_to_bw.sh file in order to run the script for your bam files on the cluster.

# Setup:

Simply edit the wrapper qsub_bam_to_bw.sh file with your desired arguments (a text file listing the full paths to your input bams on each line plus
a specification of where output files should go) and then run:

    qsub ./qsub_bam_to_bw.sh

Some of these commands take a while, so a good rule of thumb is specify 40 minutes of wall-time for each bam file.

Within the actual workhorse script that is called by the wrapper (bam_to_bw.sh), three arguments are used:
* Argument 1 is a text file where each line is the full path to an input bam
* Argument 2 is the output directory. For each bam file, a folder will be generated within this directory with the name of that sample (i.e. bam file name without the extension), 
and all files for that particular sample will be place within this sample-specific subfolder.
* Arguent 3 is the chrom sizes file, which will be genome build specific. *Make sure that you are using the chrom sizes file for your files' genome build.*

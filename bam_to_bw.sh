# Generate stranded bigwig (.bw) files from a bam file.
#     Note: make sure you are using the correct chrom sizes file for your genome build

module load makebigwigfiles;

# INPUTS:

# This should be the full path to a text file where each row is the full path to a bam file from which you wish to make stranded bigwigs files.
#input_bam_list="bam_to_bw_inputs.txt"
input_bam_list=$1

# The directory where all outputs from this script should be placed -- a folder will be generated within this folder with the name of each sample,
# and all files for that particular sample will be place within this sample-specific subfolder.
#output_dir='/projects/ps-yeolab3/ekofman/RPS2_visualization/bigwigs'
output_dir=$2

# Reference chrom sizes data
chrom_sizes='/projects/ps-yeolab3/bay001/reference_data/hg19/hg19.chrom.sizes'


for bamfilename in $(cat $input_bam_list)
do
    echo "Make bigwigs for $bamfilename..."

    samplename=$(basename "$bamfilename" | cut -d. -f1)
    echo "Sample name is $samplename... will output into folder at $output_dir/$samplename..."
    
    
    mkdir -p $output_dir/$samplename
    
    echo "Splitting by strand into two begraphs using genomecov..."
    bedtools genomecov -split -strand - -g $chrom_sizes -bg -ibam $bamfilename > $output_dir/$samplename/$samplename.fwd.bg;
    echo "Done with fwd..."
    bedtools genomecov -split -strand + -g $chrom_sizes -bg -ibam $bamfilename > $output_dir/$samplename/$samplename.rev.bg;
    echo "Done with rev..."
    
    
    echo "Sorting each split file..."
    bedtools sort -i $output_dir/$samplename/$samplename.fwd.bg > $output_dir/$samplename/$samplename.fwd.sorted.bg;
    echo "Done with fwd..."
    bedtools sort -i $output_dir/$samplename/$samplename.rev.bg > $output_dir/$samplename/$samplename.rev.sorted.bg;
    echo "Done with rev..."
    
    
    echo "Bedgraph to bigwig"
    bedGraphToBigWig $output_dir/$samplename/$samplename.fwd.sorted.bg $chrom_sizes $output_dir/$samplename/$samplename.fwd.sorted.bw
    echo "Done with fwd..."
    bedGraphToBigWig $output_dir/$samplename/$samplename.rev.sorted.bg $chrom_sizes $output_dir/$samplename/$samplename.rev.sorted.bw
    echo "Done with rev..."

    echo "Done with $samplename!"
done

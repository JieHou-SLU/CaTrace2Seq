#!/bin/bash
#--------------------------------------------------------------------------------
#  SBATCH CONFIG
#--------------------------------------------------------------------------------
#SBATCH -J  6272
#SBATCH -o 6272-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time 2-00:00
#--------------------------------------------------------------------------------

outputdir=/Users/jay/Documents/CaTrace2Seq/test/6272_out

mkdir -p /Users/jay/Documents/CaTrace2Seq/test/6272_out

cd /Users/jay/Documents/CaTrace2Seq/test/6272_out

printf "perl /Users/jay/Documents/CaTrace2Seq/scripts/CaTrace2Seq.pl /Users/jay/Documents/CaTrace2Seq/examples/6272/6272_fragment.pdb /Users/jay/Documents/CaTrace2Seq/examples/6272/6272.fasta /Users/jay/Documents/CaTrace2Seq/test/6272_out 50 10\n\n"

perl /Users/jay/Documents/CaTrace2Seq/scripts/CaTrace2Seq.pl /Users/jay/Documents/CaTrace2Seq/examples/6272/6272_fragment.pdb /Users/jay/Documents/CaTrace2Seq/examples/6272/6272.fasta /Users/jay/Documents/CaTrace2Seq/test/6272_out 50 10


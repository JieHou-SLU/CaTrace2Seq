#!/bin/bash
#--------------------------------------------------------------------------------
#  SBATCH CONFIG
#--------------------------------------------------------------------------------
#SBATCH -J  6ahv
#SBATCH -o 6ahv-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time 2-00:00
#--------------------------------------------------------------------------------

outputdir=/home/jh7x3/CaTrace2Seq/test/6ahv_out

mkdir -p /home/jh7x3/CaTrace2Seq/test/6ahv_out

cd /home/jh7x3/CaTrace2Seq/test/6ahv_out

printf "perl /home/jh7x3/CaTrace2Seq/scripts/CaTrace2Seq.pl /home/jh7x3/CaTrace2Seq/examples/6ahv/6ahv_fragment.pdb /home/jh7x3/CaTrace2Seq/examples/6ahv/6ahv.fasta /home/jh7x3/CaTrace2Seq/test/6ahv_out 50 10\n\n"

perl /home/jh7x3/CaTrace2Seq/scripts/CaTrace2Seq.pl /home/jh7x3/CaTrace2Seq/examples/6ahv/6ahv_fragment.pdb /home/jh7x3/CaTrace2Seq/examples/6ahv/6ahv.fasta /home/jh7x3/CaTrace2Seq/test/6ahv_out 50 10


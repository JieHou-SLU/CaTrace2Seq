#### install tools

## cd /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/
## git clone -b paper-version  https://github.com/DrDongSi/Ca-Backbone-Prediction.git
## cd Ca-Backbone-Prediction
##  module load python/python-3.5.2
## python3 -m venv env
## source ./env/bin/activate 
## pip install -r requirements.txt



# CaTrace2Seq
The program of mapping protein sequences into protein Ca trace drives from cryoEM image data


**(1) Download CaTrace2Seq package (short path is recommended)**

```
git clone https://github.com/DrJieHou/CaTrace2Seq.git

cd CaTrace2Seq
```


**(2) Configure CaTrace2Seq (required)**

```
perl setup_env.pl

```

**(3) Run CaTrace2Seq (required)**

```
sh run_CaTrace2Seq.sh  <path of fasta sequence> <path of Ca trace> <length threshold for fragment> <output-directory> <num of cpus>
```

**(4) Practice the examples** 

```
cd example

sh run_6272.sh



 *****************************************************************************
 *                                 TM-SCORE                                  *
 * A scoring function to assess the quality of protein structure predictions *
 * Based on statistics:                                                      *
 *       0.0 < TM-score < 0.17, Random predictions                           *
 *       0.4 < TM-score < 1.00, Meaningful predictions                       *
 * Reference: Yang Zhang and Jeffrey Skolnick, Proteins 2004 57: 702-710     *
 * For comments, please email to: yzhang@ku.edu                              *
 *****************************************************************************

Structure1: /home/jh7x  Length=  397
Structure2: 6272/pdb3j  Length=  397 (by which all scores are normalized)
Number of residues in common=  397
RMSD of  the common residues=    2.150

TM-score    = 0.9314  (d0= 7.20, TM10= 0.9314)
MaxSub-score= 0.7438  (d0= 3.50)
GDT-TS-score= 0.8086 %(d<1)=0.5819 %(d<2)=0.7431 %(d<4)=0.9093 %(d<8)=1.0000
GDT-HA-score= 0.6039 %(d<0.5)=0.1814 %(d<1)=0.5819 %(d<2)=0.7431 %(d<4)=0.9093

 -------- rotation matrix to rotate Chain-1 to Chain-2 ------
 i          t(i)         u(i,1)         u(i,2)         u(i,3)
 1     -0.0638134694   0.9999870448   0.0020705458   0.0046500556
 2      0.0280063468  -0.0020814379   0.9999950989   0.0023387491
 3      0.1425030895  -0.0046451903  -0.0023483976   0.9999864535
 
```

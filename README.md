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

**The program requires python3 or later version!!!**

**(1) Download CaTrace2Seq package (short path is recommended)**

```
git clone https://github.com/jianlin-cheng/CaTrace2Seq.git

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

sh run_STIV.sh

```

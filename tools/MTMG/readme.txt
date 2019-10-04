################################################################################
MTMG     :  Multiple Template protein Model Generation

Purpose  :  Accurate and database-free protein comparative modeling
Author   :  Jilong Li
Lab      :  Bioinformatics, Data Mining, Machine Learning Laboratory (BDML)                      
            University of Missouri, Columbia MO 65211
################################################################################

Developed By:
		Jilong Li
		Department of Computer Science
		University of Missouri, Columbia
		Email: JL482@mail.missouri.edu
Contact:
		Jianlin Cheng, PhD
		Department of Computer Science
		University of Missouri, Columbia
		Email: chengji@missouri.edu

################################################################################
1. INSTALLATION
################################################################################

MTMG requires R 3.1.0 (or newer) and GCC 4.4 (or newer).
It was tested only on x86_64-redhat-linux and may not work on other platforms.

Follow the below steps to install it:

1) unzip the tarball 
   e.g. gunzip MTMG-1.0.tar.gz
        tar xvf MTMG-1.0.tar
     or
	tar xzvf MTMG-1.0.tar.gz

2) change the directory to unzipped MTMG root directory:
   
   e.g. cd /home/your_home_dir/MTMG-1.0
	chmod -R 700 *

3) install scwrl

   e.g. cd /home/your_home_dir/MTMG-1.0/tools/scwrl
	./install_Scwrl4_Linux
	input the full path of scwrl, for example /home/your_home_dir/MTMG-1.0/tools/scwrl
	Type "Y"
	input your user name

   Installation is done!

#################################################################################
2. USAGE
#################################################################################

The executable file mtmg is the main program of MTMG, and it was compiled 
on x86_64-redhat-linux. 

Usage: 
    /home/your_home_dir/MTMG-1.0/mtmg /home/your_home_dir/MTMG-1.0/test/test1/ ss1.pir T0759 /home/your_home_dir/MTMG-1.0/test/test1/ /home/your_home_dir/MTMG-1.0 /home/your_home_dir/R-3.0.0/bin/ 0 d

Parameters:
  1. the template folder
  2. the alignment file name saved in the template folder
  3. target ID
  4. the output folder
  5. the MTMG installation folder
  6. the R installation path
  7. the parameter setting the number of iterations of sampling points
	1) 0: using the default number, # iterations = 1000 / # unfixed residues
	2) 1 ~ 500: # iterations = # unfixed residues * the input number
  8. the parameter setting the variance of sampling points
	1) d: using the default variance: the weighted average distance of points
	2) s: set variance for x, y, and z coordinates separately

#################################################################################
3. OUTPUT
#################################################################################

The .pdb file "targetID.pdb" such as "T0759.pdb" is the final predicted model
in the output folder. 

#################################################################################
4. TESTING
#################################################################################

execute mtmg as:
   
	MTMG_folder/test/test.sh MTMG_folder R_folder test_ID

	MTMG_folder: /home/your_home_dir/MTMG-1.0
	R_folder: /home/your_home_dir/R-3.0.0
	test_ID: 1 ~ 4

For example: 
	/home/your_home_dir/MTMG-1.0/test/test.sh /home/your_home_dir/MTMG-1.0 /home/your_home_dir/R-3.0.0 1

Predicted models and temporary files are saved in the output folder

################################################################################
5. DISCLAIMER
################################################################################

The executable software MTMG is distributed free of charge as it is to any 
non-commercial users. The authors hold no liabilities to the performance of the 
program.

#################################################################################
6. RELEASE NOTES
#################################################################################

Version                  Released On                    Comments
--------------------------------------------------------------------------------
1.0                     November 2015                 First released version       

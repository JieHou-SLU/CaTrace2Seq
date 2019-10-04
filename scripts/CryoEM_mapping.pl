##############  This program will be called if the length of fragment is longer than fasta sequence



##perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/CryoEM_mapping.pl  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/2GZ4_test.pdb /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/2GZ4-C.fasta  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results 10


## /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results/Models

## /scratch/jh7x3/multicom/tools/TMscore  temp_75.pdb ../../../input/2GZ4-C.pdb


## cd /scratch/jh7x3/multicom/tools/SBROD

# ./assess_protein /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results/Models/*pdb > /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results/Models/score.txt


# perl /storage/htc/bdm/jh7x3/DeepRank/src/scripts/sort_deep_qa_score.pl  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results/Models/score.txt /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/test_results/Models/score_new.txt


## cp *pdb /data/jh7x3/qprob_models/

##  /storage/htc/bdm/jh7x3/Cryo_em_paper/CryoEMSeq_v2/CryoEMSeq/tools/qprob_package/bin/Qprob.sh /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/new_simulated_map_20190831/2GZ4-C/2GZ4-C.fasta /data/jh7x3/qprob_models/ /data/jh7x3/qprob_models_out


### Table 5
##perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/CryoEM_mapping.pl  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/fragments_merged.pdb /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/5778.fasta /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/test_results 10


##perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/CryoEM_mapping.pl  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/5778_traces_refined.pdb /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/5778.fasta /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table5/Jie_mapping/test_results2 10



### Table6
##perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/CryoEM_mapping.pl  /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table6/Jie_mapping/fragments_merged.pdb /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table6/Jie_mapping/8410.fasta /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/Table6/Jie_mapping/test_results 10


#### install tools

## cd /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/
## git clone -b paper-version  https://github.com/DrDongSi/Ca-Backbone-Prediction.git
## cd Ca-Backbone-Prediction
##  module load python/python-3.5.2
## python3 -m venv env
## source ./env/bin/activate 
## pip install -r requirements.txt





our %AA3TO1 = qw(ALA A ASN N CYS C GLN Q HIS H LEU L MET M PRO P THR T TYR Y ARG R ASP D GLU E GLY G ILE I LYS K PHE F SER S TRP W VAL V);
our %AA1TO3 = reverse %AA3TO1;


if (@ARGV != 4)
{
	die "Error: need seven parameters: domain_list, domain model folder, query file(fasta), target id, output dir, modeller path, model number. \n";
}
#### 
$input_pdb = shift @ARGV;
$fasta_file = shift @ARGV;
$outputfolder = shift @ARGV;
$proc_num = shift @ARGV;

-d $outputfolder || `mkdir $outputfolder`;
#get query name and sequence 
open(FASTA, $fasta_file) || die "Error: can't read fasta file $fasta_file.\n";
@content = <FASTA>;
$target_id = shift @content;
chomp $target_id;
$qseq = shift @content;
chomp $qseq;
close FASTA;



#rewrite fasta file if it contains lower-case letter
if ($qseq =~ /[a-z]/)
{
	print "There are lower case letters in the input file. Convert them to upper case.\n";
	$qseq = uc($qseq);
	open(FASTA, ">$outputfolder/$target_id.fasta") || die "Error: can't rewrite fasta file.\n";
	print FASTA "$target_id\n$qseq\n";
	close FASTA;
}


if ($target_id =~ /^>/)
{
	$target_id = substr($target_id, 1); 
}
else
{
	die "Error: fasta foramt error.\n"; 
}

#####  (1) initialize sequence in fragment

open INPUTPDB, $input_pdb or die "ERROR! Could not open $input_pdb";
@lines_PDB = <INPUTPDB>;
close INPUTPDB;


-d "$outputfolder/frag_dir" || `mkdir $outputfolder/frag_dir`;

@PDB_temp=();
$frag_num=0;
$frag_start = 0;
%frag_CAs = {};
$CA_num = 0;
foreach (@lines_PDB) {
	$line = $_;
	chomp $line;
 
  if(substr($line,0,3) eq 'TER')
  {
    $frag_start = 0;
    next;  
  }
  
  
	next if $line !~ m/^ATOM/;
	@tmp = split(/\s+/,$line);
  $atomtype = parse_pdb_row($line,"aname");
  next if $atomtype != 'CA';
  
  
  if($frag_start == 0)
  {
    $frag_num++;
    $frag_start = 1;
    if($frag_num>1)
    {
      $idx = $frag_num-1;
      $frag_CAs{$idx} = $CA_num;
      print "Fragement $idx has $CA_num atoms\n";
      close TMP;
    }
    $fragfile = "$outputfolder/frag_dir/frag$frag_num.pdb";
    open(TMP,">$fragfile") || die "Failed to open file $fragfile\n\n";
    print TMP "$line\n";
    $CA_num = 1;
    next;
    
  }
  
  print TMP "$line\n";
  $CA_num ++;
  
}
close TMP;


print "Total $frag_num fragments are found\n";


if($frag_num == 1)
{
  ### get fragment sequence
  
  
  ##### add pulchar and side-chain
  
  
  $init_pdb = "$outputfolder/frag_dir/frag1.pdb";
  
   
  open INPUTPDB, "$outputfolder/frag_dir/frag1.pdb" or die "ERROR! Could not open $outputfolder/frag_dir/frag1.pdb\n";
  
  @lines_PDB = <INPUTPDB>; 
  close INPUTPDB;
  $pdb_seq="";
  $pdb_record = ();
  foreach (@lines_PDB) {
  	next if $_ !~ m/^ATOM/;
  	next unless (parse_pdb_row($_,"aname") eq "CA");
  	$this_rchain = parse_pdb_row($_,"chain");
  	$rname = $AA3TO1{parse_pdb_row($_,"rname")};
  	$rnum = parse_pdb_row($_,"rnum");
    if(exists($pdb_record{"$this_rchain-$rname-$rnum"}))
    {
      next;
    }else{
      $pdb_record{"$this_rchain-$rname-$rnum"} = 1;
    }
    
    $pdb_seq .= $rname;
  }
  
  if(length($pdb_seq) > length($qseq))
  {
    print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $init_pdb $fasta_file  $outputfolder $proc_num\n\n";
    `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $outputfolder/frag_dir/frag1.pdb $fasta_file  $outputfolder $proc_num`;
  }else{
    print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $init_pdb $fasta_file  $outputfolder $proc_num\n\n";
    `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $outputfolder/frag_dir/frag1.pdb $fasta_file  $outputfolder $proc_num`;
  }
}else{

  ### sort fragments by length
  $idx=0;
  foreach $fragidx (sort { $frag_CAs{$b} <=> $frag_CAs{$a} } keys %frag_CAs) 
  {
    $frag_len = $frag_CAs{$fragidx};
    if($frag_len<10)
    {
      next;
    }
    $frag1 = "$outputfolder/frag_dir/frag$fragidx.pdb";

    ##### (3) add pulchar and side-chain
    
    open(TMP1, "$frag1") || die "Failed to open $frag1\n";
    @content1 = <TMP1>;
    close TMP1;
    $Ca_index = 0;
    $atom_index=0;  
    $this_rchain="";
    $pdb_seq="";  
    -d "$outputfolder/frag_dir_sorted" || `mkdir $outputfolder/frag_dir_sorted`;
    $idx++;
    $frag1_sort = "$outputfolder/frag_dir_sorted/frag${idx}.pdb";
    open(OUTPDB,">$frag1_sort") || die "Failed to open $frag1_sort\n";
    foreach(@content1)
    {
      	$line = $_;
      	chomp $line;
      	next if $line !~ m/^ATOM/;
      	$atomCounter = parse_pdb_row($line,"anum");
      	$atomtype = parse_pdb_row($line,"aname");
      	$resname = parse_pdb_row($line,"rname");
      	$chainid = parse_pdb_row($line,"chain");
      	$resCounter = parse_pdb_row($line,"rnum");
        $this_rchain = $chainid;
        
        if($atomtype eq 'CA')
        {
          $Ca_index++;
          $pdb_seq .= $AA3TO1{$resname};
        }
        $atom_index++;
         
        $x = parse_pdb_row($line,"x");
        $y = parse_pdb_row($line,"y");
        $z = parse_pdb_row($line,"z");
       
      	
        
      	$rnum_string = sprintf("%4s", $Ca_index);
      	$anum_string = sprintf("%5s", $atom_index);
      	$atomtype = sprintf("%4s", $atomtype);
      	$x = sprintf("%8s", $x);
      	$y = sprintf("%8s", $y);
      	$z = sprintf("%8s", $z);
      	$row = "ATOM  ".$anum_string.$atomtype."  ".$resname." ".$chainid.$rnum_string."    ".$x.$y.$z."\n";
      	print OUTPDB $row;
    }
    close OUTPDB;
  

    if($idx == 1)
    {
      ### first map the largest fragment
      if(length($pdb_seq) > length($qseq))
      {
        print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num\n\n";
        `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num`;
      }else{
        print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num\n\n";
        `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num`;
      }
      
      ## score by modeleva/qprob
      
      
      ## select best one  ()
      ## write $fitted_fragments
      # /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/7proteins/3i2n_3A/test_results/frag1_fitting/Models/temp_r_NC_5.pdb 5 148




    }else{
    next;
       ### first map the largest fragment
        if(length($pdb_seq) > length($qseq))
        {
          print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num $fitted_fragments\n\n";
          `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case1.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num $fitted_fragments`;
        }else{
          print "perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num $fitted_fragments\n\n";
          `perl /storage/htc/bdm/jh7x3/Cryo_em_paper/paper_version_20190817/New_sequence_mapping_jiealgo/scripts/generate_alignment_case2.pl  $frag1_sort $fasta_file  $outputfolder/frag${idx}_fitting $proc_num $fitted_fragments`;
        }
        
        ## score by modeleva/qprob
        
        
        ## select best one  ()
    }
    
    
  }
}
################## Calculate




sub generate_gaps
{
	$gnum = $_[0]; 	
	$gaps = "";
	$i;
	for ($i = 0; $i < $gnum; $i++)
	{
		$gaps .= "-"; 
	}
	return $gaps; 
}

sub generate_aa
{
	$gnum = $_[0]; 	
	$gaps = "";
	$i;
	for ($i = 0; $i < $gnum; $i++)
	{
		$gaps .= "G"; 
	}
	return $gaps; 
}


sub parse_pdb_row{
	$row = shift;
	$param = shift;
	$result;
	$result = substr($row,6,5) if ($param eq "anum");
	$result = substr($row,12,4) if ($param eq "aname");
	$result = substr($row,16,1) if ($param eq "altloc");
	$result = substr($row,17,3) if ($param eq "rname");
	$result = substr($row,22,5) if ($param eq "rnum");
	$result = substr($row,21,1) if ($param eq "chain");
	$result = substr($row,30,8) if ($param eq "x");
	$result = substr($row,38,8) if ($param eq "y");
	$result = substr($row,46,8) if ($param eq "z");
	die "Invalid row[$row] or parameter[$param]" if (not defined $result);
	$result =~ s/\s+//g;
	return $result;
}

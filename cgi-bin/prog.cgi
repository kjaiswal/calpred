#!c:/perl/bin/perl.exe
#!c:/perl/lib

use CGI qw(:standard);
use FileHandle;
use ANN;
use SVM;

$ENV{'EMBOSSWIN'}="C:/EMBOSSwin";
$ENV{'EMBOSS_DATA'}="C:/EMBOSSwin/data";
$ENV{'Path'}="C:/EMBOSSwin";

print header(),start_html("Results...");
print '<body link="white" vlink="white" bgcolor="silver">';
$sequence=param('sequence');
$option=param('option');
$svmkernel=param('svmkernel');
$bothkernel=param('bothkernel');

print hr(),hr(),'<p align="left"><font size="5" face="Monotype Corsiva"><b>CalPred</b>: A tool for EF-hand calcium binding 
    protein prediction and calcium binding region identification.</font></p>',hr(),hr();
print '<p align="left"><font size="4" face="Monotype Corsiva">The Protein statistics along with machine learning technique\'s scores are as follows:</font></p>';

if(!(-e "blastpgp.exe"))
{print 'ERROR!!!!!!!!',br(),'Blastpgp is a pre-requisite of CalPred server!!!',br(),br(),'Blastpgp not found please see installation instructions at CalPred homepage!!!'; exit;}

if(!(-e "ncbi.ini"))
{print 'ERROR!!!!!!!!',br(),'Blastpgp is a pre-requisite of CalPred server!!!',br(),br(),'"ncbi.ini" file not found!!! <br><br>Blastpgp not installed properly, please see installation instructions at CalPred homepage!!!'; exit;}

if(!(-e "data"))
{print 'ERROR!!!!!!!!',br(),'Blastpgp is a pre-requisite of CalPred server!!!',br(),br(),'"data" directory not found!!! <br><br>Blastpgp not installed properly, please see installation instructions at CalPred homepage!!!'; exit;}

if(!(-e "svm_classify.exe"))
{print 'ERROR!!!!!!!!',br(),'SVM<sup>light</sup> is a pre-requisite of CalPred server!!!',br(),br(),'SVM<sup>light</sup> not found please see installation instructions at CalPred homepage!!!'; exit;}

if(!(-e "pepstats.exe"))
{print 'ERROR!!!!!!!!',br(),'EMBOSSWIN is a pre-requisite of CalPred server!!!',br(),br(),'PEPSTATS not found please see installation instructions at CalPred homepage!!!'; exit;}

if(!$sequence)
{print 'ERROR!!!!!!!!',br(),'Please enter a sequence!!',br(); exit;}

if(!$option)
{print 'ERROR!!!!!!!!',br(),'Please select a analyzation technique!!',br(); exit;}


my $write= new FileHandle;
$write->open(">sequence.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print($sequence);

if($option eq "ann")
{
my $pat= new ANN;
$pat->setANN("sequence.temp");
$pat->pepstats("sequence.temp");
my $read = new FileHandle;
$read->open("outfile_pepstats_ann.temp") or 
die ("Could not open outfile_pepstats_ann");
$ann_res = $read->getline();
my $write= new FileHandle;
$write->open(">>pepstats_outfile.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print("ANN Score $ann_res");
}

if($option eq "svm")
{

if($svmkernel=~ /-/)
{print "ERROR!!!!!!!!!<br>Please select a kernel type!!"; exit;}
if($svmkernel eq "linear")
{$kernel="calcium_linear";}
elsif($svmkernel eq "polynomial")
{$kernel="calcium_polynomial";}
elsif($svmkernel eq "radial")
{$kernel="calcium_radial_bais";}
elsif($svmkernel eq "sigmoidal")
{$kernel="calcium_sigmoidal_tanh";}

my $pat= new SVM;
$pat->setSVM("sequence.temp");
$pat->pepstats("sequence.temp",$kernel);

my $read = new FileHandle;
$read->open("outfile_pepstats_svm.temp") or 
die ("Could not open outfile_pepstats_svm");
$svm_res = $read->getline();
my $write= new FileHandle;
$write->open(">>pepstats_outfile.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print("SVM($kernel) Score $svm_res");
}

if($option eq "both")
{
my $annpat= new ANN;
$annpat->setANN("sequence.temp");
$annpat->pepstats("sequence.temp");
my $read = new FileHandle;
$read->open("outfile_pepstats_ann.temp") or 
die ("Could not open outfile_pepstats_ann");
$ann_res = $read->getline();


if($bothkernel=~ /-/)
{print "ERROR!!!!!!!!!<br>Please select a kernel type!!"; exit;}
if($bothkernel eq "linear")
{$kernel="calcium_linear";}
elsif($bothkernel eq "polynomial")
{$kernel="calcium_polynomial";}
elsif($bothkernel eq "radial")
{$kernel="calcium_radial_bais";}
elsif($bothkernel eq "sigmoidal")
{$kernel="calcium_sigmoidal_tanh";}

my $pat= new SVM;
$pat->setSVM("sequence.temp");
$pat->pepstats("sequence.temp",$kernel);

my $read = new FileHandle;
$read->open("outfile_pepstats_svm.temp") or 
die ("Could not open outfile_pepstats_svm");
$svm_res = $read->getline();

my $write= new FileHandle;
$write->open(">>pepstats_outfile.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print("ANN Score $ann_res");

my $write= new FileHandle;
$write->open(">>pepstats_outfile.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print("SVM($kernel) Score $svm_res");

}

my $read = new FileHandle;
$read->open("pepstats_outfile.temp") or 
	die ("Could not open pepstats_outfile");

print '<table border="1" cellspacing="2">';

while ( my $line = $read->getline() )
{
my @array=();
@array=split(' ',$line);
chomp(@array);

if($line=~ /Molecular.weight/)  
{
print Tr('<td bgcolor="#999999">',b("Molecular Weight"),'</td>', td($array[3]), '<td bgcolor="#999999">',b("Residues"),'</td>', td($array[6]));
}

if($line=~ /Average/)
{
print Tr('<td bgcolor="#999999">',b("Average Residue Weight"),'</td>', td($array[4]), '<td bgcolor="#999999">',b("Charge"),'</td>', td($array[7]));
}

if($line=~ /Isoelectric/)
{
print Tr('<td bgcolor="#999999">',b("Isoelectric Point"),'</td>', td($array[3]));
}

if($line=~ /A280.Molar/)
{
print Tr('<td bgcolor="#999999">',b("A280 Molar Extinction Coefficient"),'</td>', td($array[5]));
}

if($line=~ /A280.Extinction/)
{
print Tr('<td bgcolor="#999999">',b("A280 Extinction Coefficient 1mg/ml"),'</td>', td($array[5]));
}

if($line=~ /^Residue/)
{
print Tr('<td bgcolor="#999999">',b("Residue"),'</td>', '<td bgcolor="#999999">',b("Number"),'</td>', '<td bgcolor="#999999">',b("Mole%"),'</td>', '<td bgcolor="#999999">',b("DayhoffStat"),'</td>');
}

if( ($line=~ /A.=.Ala/) || ($line=~ /C.=.Cys/) || ($line=~ /D.=.Asp/)|| ($line=~ /E.=.Glu/) || ($line=~ /F.=.Phe/) || ($line=~ /G.=.Gly/) || ($line=~ /H.=.His/) || ($line=~ /I.=.Ile/) || ($line=~ /K.=.Lys/) || ($line=~ /L.=.Leu/) || ($line=~ /M.=.Met/) || ($line=~ /N.=.Asn/) || ($line=~ /P.=.Pro/) || ($line=~ /Q.=.Gln/) || ($line=~ /R.=.Arg/) || ($line=~ /S.=.Ser/) || ($line=~ /T.=.Thr/) || ($line=~ /V.=.Val/) || ($line=~ /W.=.Trp/) )
{
print Tr('<td bgcolor="#999999">',b("$array[0] $array[1] $array[2]"),'</td>', td($array[3]), td($array[4]), td($array[5]));
push(@vector,$array[5]);
}

if($line=~ /^Property/)
{
print Tr('<td bgcolor="#999999">',b("Property"),'</td>', '<td bgcolor="#999999">',b("Residues"),'</td>', '<td bgcolor="#999999">',b("Number"),'</td>', '<td bgcolor="#999999">',b("Mole%"),'</td>');
}
$tiny='Tiny';
$small='Small';

if($line=~ /Tiny/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Small/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Aliphatic/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Aromatic/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Non-polar/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Polar/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Charged/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"), '</td>','<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Basic/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /Acidic/)
{
print Tr('<td bgcolor="#999999">',b("$array[0]"),'</td>', '<td bgcolor="#999999">',$array[1],'</td>', td($array[2]), td($array[3]));
}

if($line=~ /ANN/)
{
print Tr('<td bgcolor="#999999">',b("$array[0] $array[1]"),'</td>', td($array[2]));
}

if($line=~ /SVM/)
{
print Tr('<td bgcolor="#999999">',b("$array[0] $array[1]"),'</td>', td($array[2]));
}

}#while
print '</table>';

print hr(),hr();

if(($ann_res >= 0.9) or ($svm_res > 0))
{
print '<p align="left"><font size="4" face="Monotype Corsiva">Your protein is predicted to be an EF-hand Calcium binding protein in nature.</font></p>';
}
elsif(($ann_res < 0.9) or ($svm_res < 0))
{
print '<p align="left"><font size="4" face="Monotype Corsiva">Your protein is predicted to be an non EF-hand Calcium binding protein in nature.</font></p>';
print hr(),hr(),br();

}

if(($ann_res >= 0.9) or ($svm_res > 0))
{
print '<p align="left"><font size="4" face="Monotype Corsiva">Identify the Ca(+2) ions binding region in the protein:</font></p>';

$menu='<form name="form1" method="post" action="identify.cgi">
<textarea name="sequence" cols="100" rows="10">'.$sequence.'</textarea>
		<select name="technique">
          <option value="-------------------" selected>--------------------</option>
          <option value="prosite">Using simple pattern matching using Prosite entry PS00018.</option>
          <option value="binary_ann">Neural Network using binary encoding method.</option>
          <option value="pssm_ann">Neural Network using PSSM matrices. (Takes time !!)</option>
          <option value="binary_svm">Support Vector Machine using binary encoding method. (Takes time !!)</option>
          <option value="pssm_svm">Support Vector Machine using PSSMs matrices. (Takes time !!)</option>
          <option value="all">Using all the available methods. (Takes time !!)</option>
        </select>
<input type="submit" name="Submit" value="Identify the Ca(+2) ion binding regions in protein.">';

print $menu;

print hr(),hr(),br();
}

print br(),'<p align="right"><a style="TEXT-DECORATION: none" href = "http://localhost/">Click here to go to home</a></p>';
print end_html();

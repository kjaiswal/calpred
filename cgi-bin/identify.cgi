#!c:/perl/bin/perl.exe
#!c:/perl/lib

use CGI qw(:standard);
use FileHandle;
use ANN;
use SVM;
use pattern;
use printer;

$ENV{'EMBOSSWIN'}="C:/EMBOSSwin";
$ENV{'EMBOSS_DATA'}="C:/EMBOSSwin/data";
$ENV{'Path'}="C:/EMBOSSwin";

print header(),start_html("Results...");
print '<body vlink="#FFFFFF" alink="#FFFFFF" bgcolor="silver">';
$sequence=param('sequence');
$option=param('technique');

print hr(),hr(),'<p align="left"><font size="5" face="Monotype Corsiva"><b>CalPred</b>: A tool for EF-hand calcium binding 
    protein prediction and calcium binding region identification.</font></p>',hr(),hr();
print '<p align="left"><font size="4" face="Monotype Corsiva">The Ca(+2) binding site prediction results are as follows:</font></p>';

my $write= new FileHandle;
$write->open(">sequence.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print($sequence);


if($option eq "prosite")  # simple pattern search
{
my $instance=new pattern;
$instance->setpattern("sequence.temp");
$instance->pattern();

my $anotherinstance=new printer;
$anotherinstance->setprinter("result_pattern.temp");
$anotherinstance->print();

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}
}

if($option eq "binary_ann")
{
my $instance=new ANN;
$instance->setANN("sequence.temp");
$instance->binary();

my $anotherinstance=new printer;
$anotherinstance->setprinter("result_binary_ann.temp");
$anotherinstance->print();

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}
}


if($option eq "pssm_ann")
{
my $instance=new ANN;
$instance->setANN("sequence.temp");
$instance->pssm("sequence.temp");

my $anotherinstance=new printer;
$anotherinstance->setprinter("result_pssm_ann.temp");
$anotherinstance->print();

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}
}


if($option eq "binary_svm")
{

my $instance=new SVM;
$instance->setSVM("sequence.temp");
$instance->binary();

my $anotherinstance=new printer;
$anotherinstance->setprinter("result_binary_svm.temp");
$anotherinstance->print();

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}

}

if($option eq "pssm_svm")
{

my $instance=new SVM;
$instance->setSVM("sequence.temp");
$instance->pssm("sequence.temp");

my $anotherinstance=new printer;
$anotherinstance->setprinter("result_pssm_svm.temp");
$anotherinstance->print();

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}

}

if($option eq "all")
{
my $instance=new pattern;
$instance->setpattern("sequence.temp");
$instance->pattern();

my $instance=new ANN;
$instance->setANN("sequence.temp");
$instance->binary();

my $instance=new ANN;
$instance->setANN("sequence.temp");
$instance->pssm("sequence.temp");

my $instance=new SVM;
$instance->setSVM("sequence.temp");
$instance->binary();


my $instance=new SVM;
$instance->setSVM("sequence.temp");
$instance->pssm("sequence.temp");

$pat=new printer;
$pat->multiprint("result_pattern.temp", "result_binary_ann.temp", "result_pssm_ann.temp", "result_binary_svm.temp", "result_pssm_svm.temp");

my $read = new FileHandle;
$read->open("result.temp") or 
die ("Could not open result file");
while($result = $read->getline())
{print "$result<br>";}

}




print hr(),hr();

$legend='
<table width="33%" border="1">
  <tr > 
    <td colspan="3"><div align="center"><em>Legends for prediction results</em></div></td>
    </tr>
  <tr bgcolor="#FFFFFF"> 
    <td width="10%"> 
      <div align="center"><strong>X</strong></div></td>
    <td width="90%"> 
      <div align="left"><em>No prediction.</em></div></td>
  </tr>
  <tr bgcolor="#CC6666"> 
    <td> 
      <div align="center"><strong>C</strong></div></td>
    <td> 
      <div align="left"><em>Calcium binding region predicted.</em></div></td>
  </tr>
</table>';

print $legend;

print br(),'<p align="right"><a style="TEXT-DECORATION: none" href = "http://localhost/">Click here to go to home</a></p>';
print end_html();

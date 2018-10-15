package printer;

use strict;
use FileHandle;

sub new  # constructor sub-routine
{
my $print={ filename => '',
		method=>'',};

bless ($print);
return $print;
}

sub setprinter
{
	if(@_==2){
	my $self=shift();
	$self->file_method($_[0]);
	$self->method_method($_[0]);
	}

	else{
	print "Method setPattern_maker requires a argument\n";
	}
}

sub file_method
{
my $self=shift();
$self->{filename}=shift() if(@_);
return $self->{filename};
}

sub method_method
{
my $self=shift();
my $file=shift() if(@_);
my $method='';

if($file eq 'result_pattern.temp')
{$method='Prosite scan';}
if($file eq 'result_binary_ann.temp')
{$method='ANN using Binary model';}
if($file eq 'result_pssm_ann.temp')
{$method='ANN using PSSM model';}
if($file eq 'result_binary_svm.temp')
{$method='SVM using Binary model';}
if($file eq 'result_pssm_svm.temp')
{$method='SVM using PSSM model';}

$self->{method}=$method;
return $self->{method};
}

sub print {

my $self=shift();
my $method=$self->{method};
my $read = new FileHandle;
my @results=();
my @file=();
my $count=0;
my $flag=0; 
my $blankline=0;
my $fastaline=0;
my @fasta=();
my $seq='';

$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}
push(@results,'<table border ="1"><tr>');
my $index=0;

my $seq=$file[0];
my $result=$file[1];
my $len =length($file[0]);
my $round=$len/60;
$round++;

foreach(1..$round)
{
my $protein=substr($seq,$index,60);
my $patt=substr($result,$index,60);
##print "$index\n$protein\n$patt\n";
push(@results,'<td bgcolor="white">Sequence</td><td bgcolor="white">'.$protein.'</td></tr><tr><td bgcolor="#CC6666">'.$method.'</td><td bgcolor="#CC6666">'.$patt.'</td></tr>');
$index=$index+60;
}
push(@results,'</table>');

my $write= new FileHandle;
$write->open(">result.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print(@results);
}

sub multiprint
{
my $self=shift();

my $one=shift() if(@_);
my $two=shift() if(@_);
my $three=shift() if(@_);
my $four=shift() if(@_);
my $five=shift() if(@_);

$self->file_method($one);
$self->method_method($one);
my $onemethod=$self->{method};
my $read = new FileHandle;
my @results=();
my @file=();
my $count=0;
my $flag=0; 
my $blankline=0;
my $fastaline=0;
my @fasta=();
my $seq='';
$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}


$self->file_method($two);
$self->method_method($two);
my $twomethod=$self->{method};
$read = new FileHandle;
$count=0;
$flag=0; 
$blankline=0;
$fastaline=0;
@fasta=();
$seq='';
$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}

$self->file_method($three);
$self->method_method($three);
my $threemethod=$self->{method};
$read = new FileHandle;
$count=0;
$flag=0; 
$blankline=0;
$fastaline=0;
@fasta=();
$seq='';
$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}

$self->file_method($four);
$self->method_method($four);
my $fourmethod=$self->{method};
$read = new FileHandle;
$count=0;
$flag=0; 
$blankline=0;
$fastaline=0;
@fasta=();
$seq='';
$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}

$self->file_method($five);
$self->method_method($five);
my $fivemethod=$self->{method};
$read = new FileHandle;
$count=0;
$flag=0; 
$blankline=0;
$fastaline=0;
@fasta=();
$seq='';
$read->open($self->{filename}) or 
	die ("Could not open $self->{filename}");
while ( my $line = $read->getline() )
{
$count++;
 if($line=~/^>.*/)
{$fastaline++; push(@fasta,$line); if($flag!=0){push(@file,$seq)} $seq=""; next;}
 elsif($line=~/^\s$/)
{$blankline++; next;}
else{$seq=$seq.$line;}
$flag++;
}
if( ($flag+$blankline+$fastaline)==$count){ push(@file,$seq);}


push(@results,'<table border ="1"><tr>');
my $index=0;
my $seq=$file[0];
my $oneresult=$file[1];
my $tworesult=$file[3];
my $threeresult=$file[5];
my $fourresult=$file[7];
my $fiveresult=$file[9];
my $len =length($file[0]);
my $round=$len/60;
$round++;

foreach(1..$round)
{
my $protein=substr($seq,$index,60);
my $onepatt=substr($oneresult,$index,60);
my $twopatt=substr($tworesult,$index,60);
my $threepatt=substr($threeresult,$index,60);
my $fourpatt=substr($fourresult,$index,60);
my $fivepatt=substr($fiveresult,$index,60);

push(@results,'<td bgcolor="white">Sequence</td><td bgcolor="white">'.$protein.'</td></tr><tr><td bgcolor="#CC6666">'.$onemethod.'</td><td bgcolor="#CC6666">'.$onepatt.'</td></tr>');
push(@results,'<tr><td bgcolor="#99CC00">'.$twomethod.'</td><td bgcolor="#99CC00">'.$twopatt.'</td></tr>');
push(@results,'<tr><td bgcolor="#9999CC">'.$threemethod.'</td><td bgcolor="#9999CC">'.$threepatt.'</td></tr>');
push(@results,'<td bgcolor="#FFFFCC">'.$fourmethod.'</td><td bgcolor="#FFFFCC">'.$fourpatt.'</td></tr>');
push(@results,'</tr><tr><td bgcolor="#CCFFCC">'.$fivemethod.'</td><td bgcolor="#CCFFCC">'.$fivepatt.'</td></tr>');

$index=$index+60;
}
push(@results,'</table>');

my $write= new FileHandle;
$write->open(">result.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print(@results);


}

return 1;
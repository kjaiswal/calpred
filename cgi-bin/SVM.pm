package SVM;

use strict;
use FileHandle;

sub new  # constructor sub-routine
{
my $pattern={ sequence => '',
		};
bless ($pattern);
return $pattern;
}

sub setSVM
{
	if(@_==2){
	my $self=shift();
	$self->sequence_method($_[0]);
	}
	else{
	print "Method setPattern_maker requires a argument\n";
	}
}

sub sequence_method
{
my $self=shift();
my $filename=shift() if(@_);
my $read = new FileHandle;

$read->open($filename) or 
	die ("Could not open $filename");
while ( my $line = $read->getline() )
{
if($line=~ /^>.*/){next;} # for fasta line
elsif($line=~/^\s$/){next;} # for spaces
else{$self->{sequence}=$self->{sequence}.$line;}
}
$self->{sequence}=~ s/\s//gi;
return $self->{sequence};
}

sub print
{
my $self=shift();
print "The sequence is:\n".$self->{sequence};
}
 

sub pepstats
{
my $self=shift();
my $filename=shift() if(@_);
my $modelname=shift() if(@_);
my $cmd="pepstats $filename pepstats_outfile.temp -auto 1";
my $out=`$cmd`;
my $read = new FileHandle;

$read->open("pepstats_outfile.temp") or 
	die ("Could not open pepstats_outfile");
my @vector=();

while ( my $line = $read->getline() )
{
my @array=();
@array=split(' ',$line);
chomp(@array);

if($line=~ /Molecular.weight/)  
{push(@vector,$array[3]/100000);}    #scaling the features and making the classification vector

if($line=~ /Average/)
{push(@vector,$array[4]/1000);}

if($line=~ /Isoelectric/)
{push(@vector,$array[3]/10);}

if($line=~ /A280.Extinction/)
{push(@vector,$array[5]/100000);}

if( ($line=~ /A.=.Ala/) || ($line=~ /C.=.Cys/) || ($line=~ /D.=.Asp/)|| ($line=~ /E.=.Glu/) || ($line=~ /F.=.Phe/) || ($line=~ /G.=.Gly/) || ($line=~ /H.=.His/) || ($line=~ /I.=.Ile/) || ($line=~ /K.=.Lys/) || ($line=~ /L.=.Leu/) || ($line=~ /M.=.Met/) || ($line=~ /N.=.Asn/) || ($line=~ /P.=.Pro/) || ($line=~ /Q.=.Gln/) || ($line=~ /R.=.Arg/) || ($line=~ /S.=.Ser/) || ($line=~ /T.=.Thr/) || ($line=~ /V.=.Val/) || ($line=~ /W.=.Trp/) )
{push(@vector,$array[4]/10);
push(@vector,$array[5]);}

if($line=~ /Tiny/)
{push(@vector,$array[3]/100);}

if($line=~ /Small/)
{push(@vector,$array[3]/100);}

if($line=~ /Aliphatic/)
{push(@vector,$array[3]/100);}

if($line=~ /Aromatic/)
{push(@vector,$array[3]/100);}

if($line=~ /Non-polar/)
{push(@vector,$array[3]/100);}

if($line=~ /Polar/)
{push(@vector,$array[3]/100);}

if($line=~ /Charged/)
{push(@vector,$array[3]/100);}

if($line=~ /Basic/)
{push(@vector,$array[3]/100);}

if($line=~ /Acidic/)
{push(@vector,$array[3]/100);}

}#while

my $write= new FileHandle;

$write->open(">infile_pepstats_svm.temp") or
		die( "Could not open to write");

$write->autoflush(1);
my $count=1;
$write->print("#Testing dataset for SVM\n");
$write->print("0 ");
foreach(@vector)
{
$write->print("$count:$_ ");
$count++;
}
$write->print("\n");
my $command = "svm_classify infile_pepstats_svm.temp $modelname outfile_pepstats_svm.temp";
my $output=`$command`;
}

 
sub binary
{
my $self=shift();
my $seqe=$self->{sequence};
my $seq="XXXXXX".$seqe."XXXXXX";
my $offset=length($seq)-13;
my $write= new FileHandle;
$write->open(">infile_binary_svm.temp") or
		die( "Could not open to write");
$write->autoflush(1);
my $count=1;
my $ccount=1;
$write->print("#Testing dataset for SVM\n");

foreach my $index(0..$offset)
{
my $subseq=substr($seq,$index,13);
my @inputs=();

foreach(0..12)
{
my $base=substr($subseq,$_,1);
my @input=qw(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0);
my @bases=qw(G A L M F W K Q E S P V I C Y H R N D T);
	foreach(0..19)
	{
		if($bases[$_] eq $base)
		{$input[$_]=1;}
	}#foreach 19
push(@inputs, @input);
}#foreach 12
$write->print("0 ");
foreach(@inputs)
{
$write->print("$ccount:$_ ");
$ccount++;
}
$write->print("\n");
$ccount=1;
$count++;
}# foreach offset

my $cmd='svm_classify infile_binary_svm.temp calcium_linear_binary outfile_binary_svm.temp';
my $out=`$cmd`;

my $len=length($seq)-12;
my $result='X';
foreach(1..($len-1))
{$result=$result.'X';}
my $count=0;
my @indices=();


my $read = new FileHandle;
$read->open("outfile_binary_svm.temp") or 
	die ("Could not open outfile_binary_svm");
while ( my $line = $read->getline() )
{
	if($line)	
	{
	chomp($line);
		if($line >= 0)
		{
		push(@indices,$count);
		}
	$count++;
	}
}

foreach(@indices)
{substr($result,$_,1,'C');}

my $final=substr($result,0,$len);

my $write= new FileHandle;
$write->open(">result_binary_svm.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print(">Sequence\n$seqe\n>Binary SVM\n$final\n");
}

sub pssm
{
my $self=shift();
my $filename=shift() if(@_);
my $cmd="blastpgp -j 3 -d calcium -i $filename -Q pssm_matrix.temp";
my $out=`$cmd`;

my $zero='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0';

my @array=();
my @pssmarray=();

foreach(1..6)
{push(@array,$zero);}

my $read = new FileHandle;
$read->open("pssm_matrix.temp") or 
	die ("Could not open pssm_matrix");
while ( my $line = $read->getline() )
{
@pssmarray=();
@pssmarray=split(' ',$line);
my $twenty = '';
	
	if($pssmarray[0]=~ /\d/)
	{
	$twenty = '';
	foreach(2..21)
	{$twenty=$twenty." ".$pssmarray[$_];}
	}
if($twenty)
{push(@array,$twenty);}
}#while

foreach(1..6)
{push(@array,$zero);}

my $write= new FileHandle;
$write->open(">infile_pssm_svm.temp") or
die( "Could not open to write");
$write->autoflush(1);
chomp(@array);
$write->print("#Testing dataset for SVM\n");

my $l=scalar(@array);
$l=$l-12;
my $counter=0;
my $lcounter=0;
my $index=1;

foreach(1..$l)
{
$lcounter=$counter+13;
	$write->print("0 ");
	my $newcount=1;

	foreach($counter..$lcounter)
	{
	my @newarray=();
	@newarray=split(' ',$array[$_]);
		foreach(@newarray)
		{	
		$write->print("$newcount:$_ ");
		$newcount++;

		}

	}
	$write->print("\n");

$counter++;
$index++;
}

my $cmd='svm_classify infile_pssm_svm.temp calcium_linear_pssm outfile_pssm_svm.temp';
my $out = `$cmd`;
my $result='X';
foreach(1..($l-1))
{$result=$result.'X';}
my $count=0;
my @indices=();

my $read = new FileHandle;
$read->open("outfile_pssm_svm.temp") or 
	die ("Could not open outfile_pssm_svm");
while ( my $line = $read->getline() )
{
	if($line)	
	{
	chomp($line);
		if($line >= 0.5)
		{
		push(@indices,$count);
		}
	$count++;
	}
}

foreach(@indices)
{substr($result,$_,1,'C');}

my $final=substr($result,0,$l);

my $write= new FileHandle;
$write->open(">result_pssm_svm.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print(">Sequence\n$self->{sequence}\n>PSSM SVM\n$final\n");

}

return 1;
 
	
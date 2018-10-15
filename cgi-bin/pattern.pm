package pattern;

use strict;
use warnings;
use FileHandle;

sub new  # constructor sub-routine
{
my $pat={ sequence => '',
		  motif=>'',};

bless ($pat);
return $pat;
}


sub setpattern
{
	if(@_==2){
	my $self=shift();
	$self->sequence_method($_[0]);
	$self->motif_method();
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
chomp($line);
if($line=~ /^>.*/){next;} # for fasta line
elsif($line=~/^\s$/){next;} # for spaces
else{$self->{sequence}=$self->{sequence}.$line;}
}

$self->{sequence}=~ s/\s//gi;
$self->{sequence}=~ s/\n//gi;

return $self->{sequence};

}

sub motif_method
{

my $self=shift();
$self->{motif}='D[^W][DNS][^ILVFYW][DENSTG][DNQGHRK][^GP][LIVMC][DENQSTAGC]..[DE][LIVMFYW]';
return $self->{motif};

}

sub pattern
{
my $self=shift();
my $filename=shift() if(@_);
my $seq=$self->{sequence};

my $index=0;
my @indices=();
my $fragment=$self->{motif};
my $len=length($seq);

while(substr($seq,$index,13))
{
$index++;
$_=substr($seq,$index,13);
	if($_=~ /$fragment/)
	{
	push(@indices,$index);
	}
}

my $result='X';
foreach(1..($len-1))
{$result=$result.'X';}


foreach(@indices)
{substr($result,$_,13,'CCCCCCCCCCCCC');}

my $write= new FileHandle;
$write->open(">result_pattern.temp") or
die( "Could not open to write");
$write->autoflush(1);
$write->print(">Sequence\n$seq\n>Prosite scan\n$result\n");


}

return 1;



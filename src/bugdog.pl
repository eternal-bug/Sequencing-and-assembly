#!perl
# Date: 2019-10
# Author: eternal-bug
# Email:  zelda_legend@163.com

use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$FindBin::Bin/lib";

my $program_list = {
      BlastScreen    => "Blast::Tblastnpx::Screen",
};

my $application = shift @ARGV;

if(not defined $application
   or $application =~ m/-h(?:elp)?/i
   or not exists $program_list->{$application}
   ){
    die &usage();
}

my $program = $program_list->{$application};

eval ( "use $program" );
if($@){
    die "$@";
}

my $obj = $program->new();
$obj->get_argument(\@ARGV);
$obj->get_start();

sub usage {
my $usage =<<EOF;
This is common toolkit to operate blast result or fasta file.
[usage]:
    
    perl bugdog.pl BlastScreen -h
EOF
}

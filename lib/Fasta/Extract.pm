package Fasta::Extract;
use strict;
use warnings;
use Fasta::Info;
use List::Util qw/first/;

sub extrict_segment_from_fasta {
    my $fasta_file = shift;
    my $title      = shift;
    my $scale_lr   = shift;
    my $offset     = shift || 0;

    my $title_sequence_hr = Fasta::Info::store_fasta($fasta_file);
    
    my $segment_hr = {};
    for my $name (keys %$title_sequence_hr){
        if ($name eq $title){
            for my $scale (@$scale_lr){
                my $str = sprintf "%d-%d",$scale->[0]+1,$scale->[1]+1;
                my $start = $scale->[0] + $offset;
                my $length = $scale->[1]-$scale->[0]+1;
                $segment_hr->{"${title}:$str"} = substr($title_sequence_hr->{$name},$start,$length);
            }
        }
    }
    return $segment_hr;
}


1;

#!/usr/bin/perl
use warnings;
use strict;
use FindBin qw/$Bin/;
use lib "$FindBin::Bin/../lib";
use File::Basename qw/dirname/;
use Getopt::Long;

use Blast::Normalize::Matrix;
use Blast::Mummer::Map;
use Blast::Mummer::Screen;


GetOptions(
    "input=s"                => \(my $input          = $ARGV[0] ),
    "length=i"               => \(my $single_len     = 500      ),  # 单次比对长度
    "part-length-percent=i"  => \(my $single_len_per = 10       ),   # single segment re
    "total-length=i"         => \(my $total_len      = 500      ),  # 总共比对长度
    "total-length-percent=i" => \(my $total_len_per  = 50       ),   # 总共比对的百分比
    "indel-number=i"         => \(my $indel_number   = 50       ),   # indel数目
    "scale-restrict"         => \(my $scale_restrict = undef    ),# 是否限制比对范围
    "start-site"             => \(my $start_site     = undef    ),# 比对开始位置
    "end-site"               => \(my $end_site       = undef    ),# 比对结束位置
    "h|help"                 => \(my $help                      ),
);



my $result;
{
open my $read,"<",$input  or die "$!";
local $/ = undef;

$result = <$read>;

close $read;
}
my $normalize_result = Blast::Normalize::Matrix::normalize("nucmer",$result);


my $screen_obj = Blast::Mummer::Screen->new();
$screen_obj->get_arguments({    
        "--length=i"               => $single_len,
        "--part-length-percent=i"  => $single_len_per,
        "--total-length=i"         => $total_len,
        "--total-length-percent=i" => $total_len_per,
        "--indel-number=i"         => $indel_number,
        "--scale-restrict"         => $scale_restrict,
        "--start-site"             => $start_site,
        "--end-site"               => $end_site, 
    });
$screen_obj->add_normalize_result($normalize_result);
$screen_obj->screen();

my $map_obj = Blast::Mummer::Map->new();

$map_obj->add_normalize_result($screen_obj->{result});

$map_obj->get_sbjct_all_delete();

$map_obj->gap_cross();

log_debug( Dumper($map_obj));

$map_obj->generate_map();

sub log_debug {
    my $info = shift;
    print STDERR $info;
}

package Blast::Mummer::Screen;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = shift || {};
    bless $self,$class;
    $self->get_arguments();
    return $self;
}

sub add_normalize_result { # 
    my $self = shift;
    my $normalize_data = shift;
    $self->{result} = $normalize_data;
}

sub get_arguments {
    my $self = shift;
    my $arguments = shift;
    my $arg = {
                "--length"               => 100,  # 单次比对长度
                "--part-length-percent"  => 10,   # single segment re
                "--total-length"         => 500,  # 总共比对长度
                "--total-length-percent" => 50,   # 总共比对的百分比
                "--indel-number"         => 50,   # indel数目
                "--scale-restrict"       => undef,# 是否限制比对范围
                "--start-site"           => undef,# 比对开始位置
                "--end-site"             => undef,# 比对结束位置
              };
    if ( defined $self->{arguments} && defined $arguments ){
        map {
                my $raw_key = $_;
                KEY:
                for my $keys ( keys $arguments  ){
                    if ($keys eq $raw_key){
                        $arg->{$raw_key} = $arguments->{$raw_key};
                        last KEY;
                    }
                }
            } keys %$arg;
    }else{
        $self->{arguments} = $arg;
    }
}

sub screen {
    my $self = shift;

    my $title = "";
    my $title_align_tmp = [];
    my $title_align_len = 0;
    my $title_len       = 1;
    my $new_snp_info    = [];
    my $whether_push    = 0;
    my $have_pushed     = 0;
    SEGMENT:
    for my $align_seg ( @{ $self->{result}->{snp} } ){
        # ========= single segment of alignment ===========

        # single segment threshold of length
        my $diff_value = abs($align_seg->[3] - $align_seg->[2]) + 1;
        if($diff_value < $self->{"arguments"}->{"--length"}){
            next SEGMENT;
        }
        
        # single segment threshold of length percent
        my $part_percent = sprintf ("%.2f",$diff_value / $title_len * 100);
        if($part_percent < $self->{"arguments"}->{"--part-length-percent"}){
            next SEGMENT;
        }

        # restrict position of alignment
        if( $self->{"arguments"}->{"--scale-restrict"} ){
            if ( $self->{"arguments"}->{"--start-site"} ||
                 $align_seg->[5] < $self->{"arguments"}->{"--start-site"}){
                next SEGMENT;
            }
            if ( $self->{"arguments"}->{"--end-site"} ||
                 $align_seg->[4] > $self->{"arguments"}->{"--end-site"}){
                next SEGMENT;
            }
        }
        
        # resrict number of indel
        if ( $align_seg->[6] > $self->{"arguments"}->{"--indel-number"} ){
            next SEGMENT;
        }
        
        my $title_tmp =  $align_seg->[0];
        if($title ne $title_tmp && $title ne ""){
            if( $self->{"arguments"}->{"--total-length"} ||
                $title_align_len < $self->{"arguments"}->{"--total-length"}){
                $whether_push = 0; # no push 
            }
            
            # the percent of alignment restriction
            my $percent = sprintf "%.2f",$title_align_len * 100 / $title_len;
            if( $self->{"arguments"}->{"--total-length-percent"} ||
                $percent < $self->{"arguments"}->{"--total-length-percent"}){
                $whether_push = 0; # no push 
            }
            
            if($whether_push){
                for my $list_lr (@{ $title_align_tmp }){
                    push @{ $new_snp_info },$list_lr;
                }
                $have_pushed = 1;
            }

            $title = $title_tmp;
            $title_len = $align_seg->[9];
            # initialize
            $whether_push = 1;
            $title_align_tmp = [];
        }else{
            $title_len = $align_seg->[9];
            $title_align_len += $diff_value;
            push @$title_align_tmp,$align_seg
        }
    }
    if(!$have_pushed && scalar(@{ $title_align_tmp }) > 0){
        for my $list_lr (@{ $title_align_tmp }){
            push @{ $new_snp_info },$list_lr;
        }
    }
    $self->{result}->{snp} = $new_snp_info;
    return $self->{result}->{snp};
}

1;

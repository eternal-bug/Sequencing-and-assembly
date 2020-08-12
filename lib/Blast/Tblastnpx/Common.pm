package Blast::Tblastnpx::Common;
use strict;
use warnings;
use 5.008001;
use Scalar::Util qw/blessed/;
use List::Util qw/max min/;
use Data::Dumper qw/Dumper/;

use File::Traversal;


sub new{
    my $class = shift;
    my $self = shift || {};
    bless $self,$class;
    return $self;
}

sub usage {
    no strict 'refs';
    my $self = shift;
    die *{SUb($self)."::usage"}{SCALAR};
}

sub get_start{ 
    no strict 'refs';

    my $self = shift;

    # files
    $self->get_file();
    
    # Traversal file list
    my $Traversal_obj = File::Traversal->new();
    $Traversal_obj->add_data($self->{"path"}->{"query"});
    $Traversal_obj->add_data($self->{"path"}->{"sbjct"});
    $Traversal_obj->get_file_compose();
    
    my $file_combine_lr;
    while($file_combine_lr = $Traversal_obj->update()){
        $self->{"file"}->{"query"} = $file_combine_lr->[0];
        $self->{"file"}->{"sbjct"} = $file_combine_lr->[1];
        # blast
        $self->get_blast($self->blast_items());
        $self->first_screen_blast();
        if($self->{exclude_itself}){
            $self->exclude_itself();
        }

        # merge
        $self->merge_blast_result(0) if $self->{"consider_all"};

        # query look up
        $self->get_query_info();
        $self->second_screen_blast();
        $self->itself_progress();
    }
}

sub get_query_info {
    my $self = shift;
    my $file = $self->{"file"}->{"query"};
    $self->{"info"}->{"query"} = Fasta::Info::fasta_length($file);
    return 1;
}

sub first_screen_blast{
    my $self = shift;
    my $blast_result;
    
    # $self->sub{$value};
    # sub1{}->sub2{}->sub3{}
    $self->{"blast_result"}->{'cooked'} = [];
    for my $num (0..scalar(@{ $self->{"blast_result"}->{'row'} })-1){
        if($self->judge_bunch($self->{"blast_result"}->{'row'}->[$num])){
            push @{$self->{"blast_result"}->{'cooked'}},$self->{"blast_result"}->{'row'}->[$num];
        }
    }

    undef $self->{"blast_result"}->{'row'};
    return $self;
}

# screen by len / identity
sub judge_bunch {
    my $self = shift;
    my $value_lr = shift;

    my $judge_score = 0;
    my $judege_item_count = 0;

    my $progress_hr = {
        "strict_length"=> sub {
                                    my $value = shift;
                                    $judge_score += &judge_value($value,$self->{"length"});
                                },
        "identity" => sub{
                                    my $value = shift;
                                    $judge_score += &judge_value($value,$self->{"identity"});
                                },
        "align_region"   => sub {
                                    my ($value_start,$value_end) = (shift,shift);
                                    ($value_start,$value_end) = ($value_end,$value_start) if $value_end < $value_start;
                                    if($value_start > $self->{"end"} || $value_end < $self->{"start"}){
                                        $judge_score += 0;
                                    }else{
                                        $judge_score += 1;
                                    }
                                },

    };

    if(not defined $self->{no_strict_length} ){
        $judege_item_count += 1;
        $progress_hr->{"strict_length"}->($value_lr->[3]);
    }

    if( defined $self->{identity} ){
        $judege_item_count += 1;
        $progress_hr->{"identity"}->($value_lr->[2]);
    }

    if( defined $self->{scale_restrict} ){
        $judege_item_count += 1;
        $progress_hr->{"align_region"}->($value_lr->[6],$value_lr->[7]);
    }
    return $judge_score == $judege_item_count;
}

sub exclude_itself{
    my $self = shift;
    if(defined $self->{"blast_result"}->{'cooked'}){
        
        @{ $self->{"blast_result"}->{'cooked'} } = grep {
                                                    my $line = $_;
                                                    my ($query,$sbjct) = ($line->[0],$line->[1]);
                                                    if($query =~ m/\Q$sbjct\E/){$line}
                                                   } @{ $self->{"blast_result"}->{'cooked'} };
        return 0;
    }else{
        warn "you should run <screen_blast> step.\n";
    }
}


sub judge_value {
    my ($value1,$value2) = @_;
    if($value1 >= $value2){
        return 1;
    }else{
        return 0;
    }
}

sub get_file{
    my $self = shift;
    $self->{"path"}->{"query"} = Read::Fasta::judge_dic_file($self->{"query"},"fas|fa|fasta");
    $self->{"path"}->{"sbjct"} = Read::Fasta::judge_dic_file($self->{"sbjct"},"fas|fa|fasta");
}

sub get_blast{
    my $self = shift;
    my $list_lr = shift;

    my $sbjct = $self->{'file'}->{'sbjct'};
    my $query = $self->{'file'}->{'query'};
   
    my $obj = Blast::Tblastnpx::Store->new({col=>$list_lr,});
    $self->{"blast_result"}->{"row"} = $obj->blast_progress($query,$sbjct,$self->{"blast_output"}) || [];

}

my @sort_item = (0,1,4);

sub sort_blast_result {
    my $self = shift;
    my $sort_type = shift;
    if(defined $self->{"blast_result"}->{'cooked'}){
        @{ $self->{"blast_result"}->{'sort'} } = sort $sort_type @{ $self->{"blast_result"}->{'cooked'} };
        undef $self->{"blast_result"}->{'cooked'};
        return 0;
    }else{
        warn "you should run <first_screen_blast> step.\n";
    }
    return 1;
}

sub merge_blast_result { 
    my $self = shift;
    my $merge_scale_retrict = shift;
    my $query_id;
    my $query_align_list_hr = {};
    $self->{"blast_result"}->{"merge"} = {};
    for my $liner (@{ $self->{"blast_result"}->{'cooked'} }){
        my $query = $liner->[0];
        my $q_start = $liner->[4];
        my $q_end   = $liner->[5];
        push @{ $query_align_list_hr->{$query} },[$q_start,$q_end];
    }
    # 开始合并
    my $merge_query_align_list_hr = {};
    for my $query (sort {$a cmp $b} keys %$query_align_list_hr){
        $merge_query_align_list_hr->{$query} = &merge_scale($query_align_list_hr->{$query});
    }
    $self->{"blast_result"}->{"merge"} = $merge_query_align_list_hr;
}

sub second_screen_blast {
    my $self = shift;
    my $hash_hr = {};
    if($self->{"consider_all"}){
        if(defined $self->{"blast_result"}->{"merge"}){
            for my $query (keys %{ $self->{"blast_result"}->{"merge"} }){
                my $total_len = 0;
                for my $value_pair ( @{ $self->{"blast_result"}->{"merge"}->{$query} }){
                    $total_len += $value_pair->[1] - $value_pair->[0] + 1;
                }
                if($self->{total_len}){
                    if($total_len < $self->{total_len}){
                        delete $self->{"blast_result"}->{"merge"}->{$query};
                    }else{
                        1;
                    }
                }

                if($self->{align_percent}){
                    my $align_percent = sprintf "%.2f",($total_len / $self->{info}->{query}->{$query})*100;
                    my @align_percent_list = split /:/, $self->{align_percent};
                    if($align_percent >= $align_percent_list[0] and $align_percent <= $align_percent_list[1] ){
                        delete $self->{"blast_result"}->{"merge"}->{$query} 
                               if exists $self->{"blast_result"}->{"merge"}->{$query};
                    }else{
                        1;
                    }
                }
            }
            return 0;
        }else{
            warn "you should run <merge_blast_result> step.\n";
        }
    }else{
        return 1;
    }
}

sub get_sequence{
    my $self = shift;

    my $title_list_lr = {};
    # remove repeat
    map {$title_list_lr->{$_->[0]}++} @{$self->{"blast_result"}->{"cooked"}};

    my $sequence_hr = FastaTtoS($self->{'file'}->{'query'},[keys %$title_list_lr]);
    return $sequence_hr;
}

sub by_list_r_sort_multi_layer {
    # closure
    my @sort_item = @sort_item;
    NEXT_LAYER : for my $num (@sort_item){
        if ($a->[$num] gt $b->[$num]){
            return 1;
        }elsif ($a->[$num] lt $b->[$num]){
            return -1;
        }else{
            next NEXT_LAYER;
        }
    }
    0;
}  

sub merge_scale {
    my $ref = shift;
    my $cross_restrict = shift || 0;

    my $temp_hr = {};
    if(ref $ref eq "ARRAY"){
        my $n = 0;
        
        for my $host_num (sort {$ref->[$a]->[0] <=> $ref->[$b]->[0]} 0..scalar(@$ref)-1){
            if($host_num+1 <= scalar(@$ref)-1){
                for my $guest_num ($host_num+1..scalar(@$ref)-1){
                    if($ref->[$host_num]->[1] + $cross_restrict < $ref->[$guest_num]->[0]
                    or $ref->[$host_num]->[0] - $cross_restrict > $ref->[$guest_num]->[1]){
                        $temp_hr->{$ref->[$host_num]->[0]} = $ref->[$host_num]->[1];
                    }else{
                        my $max = List::Util::max($ref->[$host_num]->[1],$ref->[$guest_num]->[1]);
                        my $min = List::Util::min($ref->[$host_num]->[0],$ref->[$guest_num]->[0]);
                        $temp_hr->{$min} = $max;
                        # once merge . the $n will be increase and recurrence sub
                        $n++;
                    }
                }
            }else{
                $temp_hr->{$ref->[$host_num]->[0]} = $ref->[$host_num]->[1];
            }
        }
        if ($n == 0){
            my @list = sort {$a->[0] <=> $b->[0]} @$ref;
            return \@list;
        }else{
            &merge_scale($temp_hr,$cross_restrict);
        }
    }elsif(ref $ref eq "HASH"){
        my $n = 0;
        for my $host_value (sort {$a <=> $b} keys %$ref){
            HASH: for my $guest_value (keys %$ref){
                if ($ref->{$host_value} and $ref->{$guest_value}){
                    # compare four values and extend scale
                    unless($ref->{$host_value}  + $cross_restrict < $guest_value
                                or $host_value - $cross_restrict  > $ref->{$guest_value} 
                           or ($host_value == $guest_value and $ref->{$host_value} == $ref->{$guest_value})){
                        if($host_value > $guest_value){
                            if($ref->{$host_value} >= $ref->{$guest_value}){
                                $ref->{$guest_value} = $ref->{$host_value};
                            }else{$ref->{$guest_value} = $ref->{$guest_value};}
                            delete $ref->{$host_value};
                        }
                        if($host_value < $guest_value){
                            if($ref->{$host_value} <= $ref->{$guest_value}){
                                $ref->{$host_value} = $ref->{$guest_value};
                            }else{$ref->{$host_value} = $ref->{$host_value};}
                            delete $ref->{$guest_value};
                        }
                        $n++;
                    }
                }else{
                    next HASH;
                }
            }
        }
        if ($n == 0){
            return convert_ref_to_list($ref);
        }else{
            &merge_scale($ref,$cross_restrict);
        }
    }
}

sub convert_ref_to_list{
    my $ref_hr = shift;
    my $list_lr = [];
    while(my($key,$value) = each %$ref_hr){
        push @$list_lr,[$key,$value];
    }
    return [sort {$a->[0] <=> $b->[0]} @$list_lr];
}

sub diffuse_scale {
    my $total_len = shift;
    my $scale_lr = shift;

    # merge and sort
    $scale_lr = merge_scale($scale_lr,-1);

    my $origin = [0,$total_len-1];
    my @complement = ();
    # reverse
    my $list_len = scalar(@$scale_lr)-1;
    for my $num (0..$list_len){
        if($num == 0){
            push @complement,[0,$scale_lr->[$num]->[0]-1];
        }elsif($num < $list_len){
            my $left = $scale_lr->[$num]->[1];
            my $right = $scale_lr->[$num+1]->[0]-2;
            if($left < $right){
                push @complement,[$left,$right];
            }
        }else{
            if($scale_lr->[$num]->[1] < $total_len - 1){
                push @complement,[$scale_lr->[$num]->[1],$total_len - 1];
            }
        }
    }
    return remove_no_use_scale(\@complement);
}

sub remove_no_use_scale {
    my $list_lr = shift;

    my $list_len = scalar(@$list_lr) - 1;
    my @new_list;
    for my $num (0..$list_len){
        if($list_lr->[$num]->[0] == $list_lr->[$num]->[1]){
            # splice(@$list_lr,$num,1);
            1;
        }else{
            push @new_list,$list_lr->[$num];
        }
    }
    return \@new_list;
}

1;

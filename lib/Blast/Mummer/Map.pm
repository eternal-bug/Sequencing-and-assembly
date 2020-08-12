package Blast::Mummer::Map;
use strict;
use warnings;
use Fasta::Extract;
use Seq::Transform;
use Clone qw/clone/;
use Data::Dumper qw/Dumper/;

# test
sub log_bug {
    my $info = shift;
    print STDERR "$info\n";
}

# oo
sub new {
    my $class = shift;
    my $self = shift || {};
    bless $self,$class;
}

sub add_normalize_result { # 
    my $self = shift;
    my $data = shift;
    $self->{result} = $data;
}

sub get_sbjct_all_delete {
    my $self = shift;
    my %gather_sbjct_delete = ();
    
    # each align segment
    for my $num (0..scalar(@{ $self->{result}->{snp} }) - 1){
        my $matrix = $self->{result}->{snp}->[$num];
        # each gap in each slign segment
        for my $sbjct_gap ( @{ $matrix->[8] } ){
            if( exists $gather_sbjct_delete{$sbjct_gap->[0]} ){
                if( $gather_sbjct_delete{$sbjct_gap->[0]} < $sbjct_gap->[1] ){
                    $gather_sbjct_delete{$sbjct_gap->[0]} = $sbjct_gap->[1];
                }
            }else{
                $gather_sbjct_delete{$sbjct_gap->[0]} = $sbjct_gap->[1];
            }
        }
    }
    $self->{result}->{all} = \%gather_sbjct_delete;
    return {%gather_sbjct_delete};
}


sub gap_cross {
    my $self = shift;
    # first data set
    # cost round times is ( n + (n-1) + (n-2) + ... + 1 );
    HOST:
    for my $num_host (0..scalar(@{ $self->{result}->{snp} })-1){ # 每一个就是一个比对片段信息
        my $host_snp_info = $self->{result}->{snp}->[$num_host];
        if($num_host+1 > scalar(@{ $self->{result}->{snp} })-1){
            last HOST;
        }
        # second data set
        if( scalar(@{ $host_snp_info->[7] }) > 1){
            $host_snp_info->[7] = [sort {
                                            $a->[0] <=> $b->[0] 
                                        } @{ $host_snp_info->[7] }];
        }
        if( scalar(@{ $host_snp_info->[8] }) > 1){
            $host_snp_info->[8] = [sort { 
                                            $a->[0] <=> $b->[0]
                                        } @{ $host_snp_info->[8] }];
        }
        # host sbjct align start and end site (no contain delete)
        my $host_S_s       = $host_snp_info->[4];
        my $host_S_e       = $host_snp_info->[5];

        GUEST:
        for my $num_guest ($num_host+1..scalar(@{ $self->{result}->{snp} })-1){
            my $guest_snp_info = $self->{result}->{snp}->[$num_guest];
            
            if( scalar(@{ $guest_snp_info->[7] }) > 1){
                $guest_snp_info->[7] = [sort {
                                                $a->[0] <=> $b->[0]
                                            } @{ $guest_snp_info->[7] }];
            }
            if( scalar(@{ $guest_snp_info->[8] }) > 1){
                $guest_snp_info->[8] = [sort {
                                                $a->[0] <=> $b->[0]
                                             } @{ $guest_snp_info->[8] }];
            }
            
            # guest sbjct align start and end site (no contain delete)
            my $guest_S_s      = $guest_snp_info->[4]; 
            my $guest_S_e      = $guest_snp_info->[5];

            if ($host_S_e < $guest_S_s or $host_S_s > $guest_S_e){ # no cross
                next GUEST;
            }else{ # cross
                compare_list(
                            $host_snp_info->[8], # list1
                            $guest_snp_info->[8], # list2
                            *by_list_list_0, # sort ruler
                            \&_host_diff_action,
                            \&_guest_diff_action,
                            \&_host_same_action,
                            \&_guest_same_action,
                            $host_snp_info,
                            $guest_snp_info,
                            );
            }
        }
    }
    return $self->{result};
}

sub generate_map {
    my $self = shift;
    my $all_sbjct_delete = $self->{result}->{all};
    my $query_path       = $self->{"result"}->{"file"}->{"query"};
    my $sbjct_path       = $self->{"result"}->{"file"}->{"sbjct"};
    
    my $sbjct_ID = $self->{result}->{snp}->[0]->[1];
    my $sbjct_seq = Fasta::Extract::extrict_sequence_from_fasta($sbjct_path,[$sbjct_ID]);
    # descend sort
    for my $site (sort {$b <=> $a } keys %$all_sbjct_delete){
        substr($sbjct_seq->{$sbjct_ID},$site,0) = "-" x $all_sbjct_delete->{$site};
    }
    # sbjct len ( original + gap )
    my $sbjct_len = length($sbjct_seq->{$sbjct_ID});
    print ">",$sbjct_ID,"\n";
    print $sbjct_seq->{$sbjct_ID},"\n";
    
    # draw query
    # consider reverse align...
    for my $segment (@{ $self->{result}->{snp} }){
        
        my $sbjct_start = $segment->[4];
        my $query_ID = $segment->[0];
        my ($left,$right) = ($segment->[2]-1,$segment->[3]-1); # machine site
        if($left > $right){
            ($left,$right) = ($right,$left);
        }
        my $scale = [[$left,$right]];
        my $all_delete_lr = $segment->[7];
        
        my $query_seq = Fasta::Extract::extrict_segment_from_fasta($query_path,$query_ID,$scale);
        for my $delete_lr (sort {$b->[0] <=> $a->[0] } @{$all_delete_lr}){
            if ( length($query_seq->{$query_ID}) > $delete_lr->[0] - 1 - ($scale->[0]->[0]-1) ){
                substr($query_seq->{$query_ID},$delete_lr->[0] - 1 - ($scale->[0]->[0]),0) = "-" x $delete_lr->[1];
            }
        }

        my $accumulate_gap = 0;
        SBJCT_GAP:
        for my $site (sort {$a <=> $b} keys %$all_sbjct_delete ){
            if($site < $sbjct_start ){
                $accumulate_gap += $all_sbjct_delete->{$site};
            }else{
                last SBJCT_GAP;
            }
        }

        my $query_title = sprintf "%s",$query_ID;
        my $prefix      = sprintf "%s","-" x ($sbjct_start - 1 + $accumulate_gap);
        my $seq;
        my $suffix      = sprintf "%s","-" x ($sbjct_len - length($query_seq->{$query_ID}) - length($prefix));
        if($segment->[2] > $segment->[3]){
            $seq = Seq::Transform::seq_comp_rev($query_seq->{$query_ID});
        }else{
            $seq = $query_seq->{$query_ID};
        }
        print_items_to_handle(">",$query_title,"\n",$prefix,$seq,$suffix,"\n");
    }
}

sub print_items_to_handle {
    my $handle = shift;
    if (ref $handle ){
        1;
    }else {
        unshift @_,$handle;
        $handle = *{STDOUT};
    }
    map {print {$handle} $_} @_;
}

sub compare_list {
    my ($list1_lr,$list2_lr,$sort_ruler) = (shift,shift,shift);
    my ($action_1_diff,
        $action_2_diff,
        $action_1_same,
        $action_2_same,) = (
                            shift || sub {},
                            shift || sub {},
                            shift || sub {},
                            shift || sub {},
                        );
    
    my $host_snp_info = shift;
    my $guest_snp_info = shift;
    
    # $list1_lr = [sort $sort_ruler @$list1_lr];
    # $list2_lr = [sort $sort_ruler @$list2_lr];
    
    my ($site1,$site2) = (0,0);
    
    L:
    if($site1 <= scalar(@$list1_lr) - 1 and $site2 <= scalar(@$list2_lr) - 1){
        if($list1_lr->[$site1]->[0] != $list2_lr->[$site2]->[0]){
            if($list1_lr->[$site1]->[0] < $list2_lr->[$site2]->[0]){
                $action_1_diff->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
                $site1++;
            }else{
                $action_2_diff->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
                $site2++;
            }
        }else{ 
            if( $list1_lr->[$site1]->[1] < $list2_lr->[$site2]->[1] ){
                $action_1_same->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
            }elsif( $list1_lr->[$site1]->[1] > $list2_lr->[$site2]->[1] ){
                $action_2_same->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
            }
            $site1++;
            $site2++;
        }
    }else{ 
        if($site1 <= scalar(@$list1_lr) - 1){
            $action_1_diff->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
            $site1++;
        }elsif($site2 <= scalar(@$list2_lr) - 1){
            $action_2_diff->($list1_lr,$list2_lr,\$site1,\$site2,$host_snp_info,$guest_snp_info);
            $site2++;
        }
    }
    if($site1 <= scalar(@$list1_lr) - 1 or $site2 <= scalar(@$list2_lr) - 1){goto L};
}

#                    
#       |  as   |  ag |as|
# sbjct =========------==========------=======
#       ^start_s

#       |bs|bg|    bs    |
# query ===---==============---===============
#       ^start_q
#                        ^
#                     insert site

# l is segment length; site is delete site;
# start is align start point; gap is total gap before this site;

# forward align
#   8                90
# ======================
#   ==================
#   5                87
#   !!!!!!!^
#   ->->->->
# l.s = site.s - start.s + 1 + gap.s                  (1)
# l.q = site.q - start.q + 1 + gap.q                  (2)
# l.s = l.q                                           (3)
# site.q = site.s - start.s + gap.s + start.q - gap.q (4)

# reverse align ( Be careful!! The gap will be descend order )
#   8                90
# ======================
#   ==================
#   87               5
#   !!!!!!!^
#   <-<-<-<-
# site.q = end.q + gap.q - (site.s - start.s + gap.s) (4)

# be careful!!!
#       v
# ===============>
# <==============
#       ^
# add gap -
# ======-========>
# <======-========
# so calculate sbjct site to query site (reverse align should be add 1)

# query_insert = as + ag + as - bg + start_q   # s is sequence , g is gap

sub _host_diff_action { # host contain , guest no contain
    # $list_h_lr = [site,count]
    # $list_h_lr is a series of host  sbjct delete infomation
    #          $list_h_lr = $host_snp_info->[8]
    # $list_g_lr is a series of guest sbjct delete infomation
    #          $list_g_lr = $guest_snp_info->[8];
    # $site_h_sr is host site ref (machine num(-1))
    # $site_g_sr is guest site ref (machine num(-1))
    my ($list_h_lr,$list_g_lr,$site_h_sr,$site_g_sr,$host_snp_info,$guest_snp_info) = @_;
    # host snp sbjct delete site
    my $host_s  = $host_snp_info->[8]->[$$site_h_sr];
    # a series of snp infomations of guest
    my $guest_Q_snp_lr = $guest_snp_info->[7];

    my $start_site = $guest_snp_info->[4]; # sbjct align start site
    my $end_site   = $guest_snp_info->[5]; # sbjct align end site
    
    if($host_s->[0] >= $start_site and $host_s->[0] <= $end_site){
        my $sbjct_gap_num = 0; # behind the $site_g_sr the gap count
        # accumulate the gap count
        map { $sbjct_gap_num += $list_g_lr->[$_]->[1] } 0..$$site_g_sr-1 if $$site_g_sr > 0;
        my $sbjct_base_len = $host_s->[0] - $start_site + 1;       # site.s - start.s
        my $total_len      = $sbjct_base_len + $sbjct_gap_num; # site.s - start.s + gap.s
        
        splice(@$list_g_lr,$$site_g_sr,0,clone($host_s));
        ${$site_g_sr}++;
        
        # judge forward or reverse alignment
        my $query_left = $guest_snp_info->[2];
        my $query_right = $guest_snp_info->[3];
        my $accumulate = 0;
        my $n = 0;
        if ( $query_left < $query_right ){
        # ============ forward alignment =========
            ACCUMULATE:
            for($n = 0;$n < scalar(@$guest_Q_snp_lr);$n++){
                my $site  = $guest_Q_snp_lr->[$n]->[0];
                my $count = $guest_Q_snp_lr->[$n]->[1];
                if( $total_len - $site - $accumulate < 0){
                    last ACCUMULATE; # meet the max $n value
                }else{
                    # if insert delete site between the gap site start and gap site end.
                    # should add it to this gap site.
                    if( $total_len - $site - $accumulate > 0 && 
                        $total_len - $site - $accumulate - $count < 0){
                        $accumulate = $total_len - $site + 1;
                        $n++;
                        last ACCUMULATE;
                    }
                }
                $accumulate += $guest_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left + $total_len - $accumulate; # 
            if(exists $guest_Q_snp_lr->[$n] && $guest_Q_snp_lr->[$n]->[0] == $query_site){
                $guest_Q_snp_lr->[$n]->[1] += $host_s->[1];
            }else{
                splice(@$guest_Q_snp_lr,$n,0,[$query_site,$host_s->[1]]);
            }
        }else{
        # ============ reverse alignment ==================
            ACCUMULATE:
            for($n = scalar(@$guest_Q_snp_lr)-1;0 <= $n;$n--){
                my $site  = $guest_Q_snp_lr->[$n]->[0];
                my $count = $guest_Q_snp_lr->[$n]->[1];
                if(  $site + $total_len - $accumulate < $query_left ){
                    last ACCUMULATE;
                }else{
                    if( $site + $total_len - $accumulate < $query_left &&
                        $site + $total_len - $accumulate + $count > $query_left ){
                        $accumulate = $total_len - $query_left + $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $guest_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }

            my $query_site = $query_left - $total_len + $accumulate;
            if(exists $guest_Q_snp_lr->[$n] && $guest_Q_snp_lr->[$n]->[0] == $query_site){
                $guest_Q_snp_lr->[$n]->[1] += $host_s->[1];
            }else{
                splice(@$guest_Q_snp_lr,$n,0,[$query_site + 1,$host_s->[1]]);
            }
        }
    }
}

sub _guest_diff_action {  # guest contain , host no contain
    # $list_h_lr = [site,count]
    my ($list_h_lr,$list_g_lr,$site_h_sr,$site_g_sr,$host_snp_info,$guest_snp_info) = @_;
    my $guest_s  = $guest_snp_info->[8]->[$$site_g_sr];
    my $host_Q_snp_lr  = $host_snp_info->[7];
    
    my $start_site = $host_snp_info->[4];
    my $end_site   = $host_snp_info->[5];
    
    if($guest_s->[0] >= $start_site and $guest_s->[0] <= $end_site){
        my $sbjct_gap_num = 0;
        map { $sbjct_gap_num+= $list_h_lr->[$_]->[1] } 0..$$site_h_sr-1  if $$site_h_sr > 0;
        my $sbjct_base_len = $guest_s->[0] - $start_site + 1; # as + as
        my $total_len      = $sbjct_base_len + $sbjct_gap_num; # as + as + ag
        
        splice(@$list_h_lr,$$site_h_sr,0,clone($guest_s));
        $$site_h_sr++;

        my $query_left = $host_snp_info->[2];
        my $query_right = $host_snp_info->[3];
        my $accumulate = 0;
        my $n = 0;
        if ( $query_left < $query_right){
            ACCUMULATE:
            for($n = 0; $n < scalar(@$host_Q_snp_lr);$n++){
                my $site  = $host_Q_snp_lr->[$n]->[0];
                my $count = $host_Q_snp_lr->[$n]->[1];
                if( $total_len - $site - $accumulate + 1 < 0){
                    last ACCUMULATE;
                }else{
                    if( $total_len - $site - $accumulate + 1 > 0 and
                        $total_len - $site - $accumulate - $count < 0){
                        $accumulate = $total_len - $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $host_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left + $total_len - $accumulate;
            if(exists $host_Q_snp_lr->[$n] && $host_Q_snp_lr->[$n]->[0] == $query_site){
                $host_Q_snp_lr->[$n]->[1] += $guest_s->[1];
            }else{
                splice(@$host_Q_snp_lr,$n,0,[$query_site,$guest_s->[1]]);
            }
        }else{
            ACCUMULATE:
            for($n = scalar(@$host_Q_snp_lr)-1;0 <= $n;$n--){
                my $site  = $host_Q_snp_lr->[$n]->[0];
                my $count = $host_Q_snp_lr->[$n]->[1];
                if( $site + $total_len - $accumulate < $query_left){
                    last ACCUMULATE;
                }else{
                    if( $site + $total_len - $accumulate < $query_left and
                        $site + $total_len - $accumulate + $count > $query_left){
                        $accumulate = $total_len - $query_left + $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $host_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left - $total_len + $accumulate;
            if(exists $host_Q_snp_lr->[$n] && $host_Q_snp_lr->[$n]->[0] == $query_site){
                $host_Q_snp_lr->[$n]->[1] += $guest_s->[1];
            }else{
                splice(@$host_Q_snp_lr,$n,0,[$query_site + 1,$guest_s->[1]]);
            }
        }
    }
}

sub _host_same_action {
    # $list_h_lr = [site,count]
    my ($list_h_lr,$list_g_lr,$site_h_sr,$site_g_sr,$host_snp_info,$guest_snp_info) = @_;
    my $guest_s  = $guest_snp_info->[8]->[$$site_g_sr];
    my $host_s  = $host_snp_info->[8]->[$$site_h_sr];
    my $host_Q_snp_lr  = $host_snp_info->[7];
    
    my $same_site = $list_h_lr->[$$site_h_sr] || $list_g_lr->[$$site_g_sr];
    
    my $start_site = $host_snp_info->[4];
    my $end_site   = $host_snp_info->[5];
    
    # if($host_s->[0] > $start_site and $host_s->[0] < $end_site){
        my $diff_value = $list_g_lr->[$$site_g_sr]->[1] - $list_h_lr->[$$site_h_sr]->[1];
        
        my $sbjct_gap_num = 0;
        map { $sbjct_gap_num+= $list_h_lr->[$_]->[1] } 0..$$site_h_sr;
        my $sbjct_base_len = $host_s->[0] - $start_site + 1; # as + as
        my $total_len      = $sbjct_base_len + $sbjct_gap_num; # as + as + ag
        
        $list_h_lr->[$$site_h_sr]->[1] += $diff_value;
        # judge forward or reverse alignment
        my $query_left = $host_snp_info->[2];
        my $query_right = $host_snp_info->[3];
        
        my $accumulate = 0;
        my $n = 0;
        if ( $query_left < $query_right){

            ACCUMULATE:
            for($n = 0; $n < scalar(@$host_Q_snp_lr);$n++){
                my $site  = $host_Q_snp_lr->[$n]->[0];
                my $count = $host_Q_snp_lr->[$n]->[1];
                if( $total_len - $site - $accumulate < 0){
                    last ACCUMULATE;
                }else{
                    if( $total_len - $site - $accumulate > 0 and
                        $total_len - $site - $accumulate - $count< 0){
                        $accumulate = $total_len - $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $host_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left + $total_len - $accumulate;
            if(exists $host_Q_snp_lr->[$n] && $host_Q_snp_lr->[$n]->[0] == $query_site){
                $host_Q_snp_lr->[$n]->[1] += $guest_s->[1];
            }else{
                splice(@$host_Q_snp_lr,$n,0,[$query_site,$diff_value]);
            }
        }else{ # ======================= reverse alignment ==================
            ACCUMULATE:
            for($n = scalar(@$host_Q_snp_lr)-1; 0 <= $n ;$n--){
                my $site  = $host_Q_snp_lr->[$n]->[0];
                my $count = $host_Q_snp_lr->[$n]->[1];
                if( $site + $total_len - $accumulate < $query_left ){
                    last ACCUMULATE;
                }else{
                    if( $site + $total_len - $accumulate < $query_left and
                        $site + $total_len - $accumulate + $count > $query_left){
                        $accumulate = $total_len - $query_left + $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $host_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left - $total_len + $accumulate;
            if(exists $host_Q_snp_lr->[$n] && $host_Q_snp_lr->[$n]->[0] == $query_site){
                $host_Q_snp_lr->[$n]->[1] += $diff_value;
            }else{ 
                splice(@$host_Q_snp_lr,$n,0,[$query_site+1,$diff_value]);
            }
        }
    # }
}

sub _guest_same_action {
    # $list_h_lr = [site,count]
    my ($list_h_lr,$list_g_lr,$site_h_sr,$site_g_sr,$host_snp_info,$guest_snp_info) = @_;
    my $guest_s  = $guest_snp_info->[8]->[$$site_g_sr];
    my $host_s  = $host_snp_info->[8]->[$$site_h_sr];
    my $guest_q  = $guest_snp_info->[7];
    my $guest_Q_snp_lr  = $guest_snp_info->[7];

    my $same_site = $list_h_lr->[$$site_h_sr] || $list_g_lr->[$$site_g_sr];
    
    my $start_site = $guest_snp_info->[4];
    my $end_site   = $guest_snp_info->[5];
    
    # if($host_s->[0] > $start_site and $host_s->[0] < $end_site){
        my $diff_value = $list_h_lr->[$$site_h_sr]->[1] - $list_g_lr->[$$site_g_sr]->[1];
        
        my $sbjct_gap_num = 0;
        map { $sbjct_gap_num+= $list_g_lr->[$_]->[1] } 0..$$site_g_sr;
        my $sbjct_base_len = $host_s->[0] - $start_site + 1; # as + as
        my $total_len      = $sbjct_base_len + $sbjct_gap_num; # as + as + ag
        
        $list_g_lr->[$$site_g_sr]->[1] += $diff_value;
        # judge forward or reverse alignment
        my $query_left = $guest_snp_info->[2];
        my $query_right = $guest_snp_info->[3];
        if ( $query_left < $query_right){ # ============ forward alignment =========
            my $accumulate = 0;
            my $n = 0;
            ACCUMULATE:
            for($n = 0; $n < scalar(@$guest_Q_snp_lr);$n++){
                my $site  = $guest_Q_snp_lr->[$n]->[0];
                my $count = $guest_Q_snp_lr->[$n]->[1];
                if( $total_len - $site - $accumulate + 1 < 0){
                    last ACCUMULATE;
                }else{
                    if( $total_len - $site - $accumulate > 0 and
                       $total_len - $site - $accumulate - $count < 0){
                        $accumulate = $total_len - $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $guest_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left + $total_len - $accumulate;
            if(exists $guest_Q_snp_lr->[$n] && $guest_Q_snp_lr->[$n]->[0] == $query_site){
                $guest_Q_snp_lr->[$n]->[1] += $host_s->[1];
            }else{
                splice(@$guest_Q_snp_lr,$n,0,[$query_site,$diff_value]);
            }
        }else{ # ======================= reverse alignment ==================
            my $accumulate = 0;
            my $n = 0;
            ACCUMULATE:
            for($n = scalar(@$guest_Q_snp_lr)-1; 0 <= $n ;$n--){
                my $site  = $guest_Q_snp_lr->[$n]->[0];
                my $count = $guest_Q_snp_lr->[$n]->[1];
                if( $site + $total_len - $accumulate < $query_left ){
                    last ACCUMULATE;
                }else{
                    if( $site + $total_len - $accumulate < $query_left and
                        $site + $total_len - $accumulate + $count > $query_left){
                        $accumulate = $total_len - $query_left + $site;
                        last ACCUMULATE;
                    }else{
                        1;
                    }
                }
                $accumulate += $guest_Q_snp_lr->[$n]->[1];
            }
            if($n == -1){
               $n = 0; 
            }
            my $query_site = $query_left - ($total_len - $accumulate);
            if(exists $guest_Q_snp_lr->[$n] && $guest_Q_snp_lr->[$n]->[0] == $query_site){
                $guest_Q_snp_lr->[$n]->[1] += $diff_value;
            }else{
                splice(@$guest_Q_snp_lr,$n,0,[$query_site + 1,$diff_value]);
            }
        }
    # }
}

sub by_sbjctid_sbjctstart {
    $a->[2] cmp $b->[2] ||
    $a->[4] <=> $b->[4];
}

sub by_list_list_0 {
    $a->[0] <=> $b->[0];
}

1;

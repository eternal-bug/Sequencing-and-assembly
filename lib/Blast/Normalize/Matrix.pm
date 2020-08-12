package Blast::Normalize::Matrix;
use IO::Scalar;


BEGIN{
    use vars qw/%normalize/;
    %diff_pro_normalize = (
        nucmer => \&normalize_mummer,
        mummer => \&normalize_mummer,
    );
}

sub normalize {
    my $align_type = shift;
    my $result = shift;
    my $normalize_result = $diff_pro_normalize{lc($align_type)}->($result);
    return $normalize_result;
}

# 数据结构
#    self
#      |
#   +  |-- file
#      |     |-- query
#      |     |-- sbjct
#      |                0         1       2      3        4       5       6          7               8           9     10
#   -  |-- snp   -> [query.ID,sbjct.ID,query.s,query.e,sbjct.s,sbjct.e,snp_num,[q.delete.site],[s.delete.site],Q.len,S.len]
#      |                0         1       2      3        4       5       6 
#   +  |-- align -> [query.ID,sbjct.ID,query.s,query.e,sbjct.s,sbjct.e,identity]

sub normalize_mummer{
    my $align_re   = qr/^>/;             
    my $segment_re = qr/^\d+\s+\d+\s+/;
    my $snp_re     = qr/^[-\d]+/;
    my $nucmer_fruit = shift;
    my $fh = IO::Scalar->new(\$nucmer_fruit);
    
    my $result_hr;
    my $n = 0;
    my $snp_list_temp_ref;
    my $align_list_temp_ref;
    my $query_snp_delete_count_lr = [];
    my $sbjct_snp_delete_count_lr = [];
    my $accumulate_query = 0;
    my $accumulate_sbjct = 1;
    my ($query_title,$sbjct_title,$query_len,$sbjct_len);
    my ($Q_indel_site,$S_indel_site) = (0,0);
    my ($Q_s,$Q_e,$S_s,$S_e,$snp_num);
    
    my $symbol_same = 0;

    my $new_snp_site_flag = 0;
    while(<$fh>){
        chomp;
        $n++;
        # align informations
        # 1: file path
        # 2: program type
        if($n < 3){
            if($n == 1){
                my @file = split /\s+/, $_;
                $result_hr->{file}->{sbjct} = $file[0];
                $result_hr->{file}->{query} = $file[1];
            }
        }else{
        
            if(m/$align_re/){
                $accumulate_query = 0;
                $accumulate_sbjct = 1;
                s/^>//;
                my @temp = split /\s+/,$_;
                $sbjct_title = $temp[0];
                $query_title = $temp[1];
                $sbjct_len   = $temp[2];
                $query_len   = $temp[3];
                next;
            }
            
            if(m/$snp_re/){
                # | 1   | 2    | 3     | 4     | 5     | 6   | 7 |
                # | S.s | S.e  | Q.s   | Q.e   | indel |
                # |4683 | 6247 | 54123 | 52561 | 105   | 105 | 0 |

                if(m/$segment_re/){
                    $query_snp_delete_count_lr = [];
                    $sbjct_snp_delete_count_lr = [];
                    $new_snp_site_flag = 1;
                    
                    $accumulate_query = 1;
                    $accumulate_sbjct = 1;
                    my @align_info;
                    my @snp_info;
                    my @temp = split /\s+/,$_;
                    
                    ($S_s,$S_e,$Q_s,$Q_e,$snp_num) = @temp;
                    
                    push @{ $result_hr->{snp} } , \@snp_info;
                    push @{ $result_hr->{align} }, \@align_info;
                    $snp_list_temp_ref = \@snp_info;
                    $align_list_temp_ref = \@align_info;
                    @align_info = (
                                    $query_title, # 0
                                    $sbjct_title, # 1
                                    $Q_s,         # 2
                                    $Q_e,         # 3
                                    $S_s,         # 4
                                    $S_e,         # 5
                                    sprintf("%.2f",$snp_num/(abs($Q_e-$Q_s)+1) * 100), # 6
                                    );
                    @snp_info = (
                                    $query_title, # 0
                                    $sbjct_title, # 1
                                    $Q_s,         # 2
                                    $Q_e,         # 3
                                    $S_s,         # 4
                                    $S_e,         # 5
                                    $snp_num,     # 6
                                    [],           # 7
                                    [],           # 8
                                    $query_len,   # 9
                                    $sbjct_len,   # 10
                                );
                }elsif($_ != 0){
                    $accumulate_flash += abs($_);

                    if(abs($_) != 1){
                        $accumulate_query += abs($_);
                        $accumulate_sbjct += abs($_);

                        if(defined $query_snp_delete_count_lr->[0]){
                            push @{ $snp_list_temp_ref->[7] },$query_snp_delete_count_lr;
                        }
                        
                        if(defined $sbjct_snp_delete_count_lr->[0]){
                            push @{ $snp_list_temp_ref->[8] },$sbjct_snp_delete_count_lr;
                        }
                        
                        # 初始化
                        $query_snp_delete_count_lr = [];
                        $sbjct_snp_delete_count_lr = [];
                        
                        if($_ < 0){
                            $accumulate_sbjct -= 1;
                            $sbjct_snp_delete_count_lr = [$S_s + $accumulate_sbjct - 1,1];
                        }else{
                            if($Q_s > $Q_e){
                                $accumulate_query -= 1;
                                $query_snp_delete_count_lr = [$Q_s - $accumulate_query + 1,1];
                            }else{
                                $accumulate_query -= 1;
                                $query_snp_delete_count_lr = [$Q_s + $accumulate_query - 1,1];
                            }
                        }
                    }else{
                        if($_ < 0){
                            $accumulate_query += abs($_);
                            $sbjct_snp_delete_count_lr->[1]++;
                        }else{
                            $accumulate_sbjct += abs($_);
                            $query_snp_delete_count_lr->[1]++;
                        }
                    }
                }else{
                    if(defined $query_snp_delete_count_lr->[0]){
                        push @{ $snp_list_temp_ref->[7] },$query_snp_delete_count_lr;
                    }
                    
                    if(defined $sbjct_snp_delete_count_lr->[0]){
                        push @{ $snp_list_temp_ref->[8] },$sbjct_snp_delete_count_lr;
                    }
                    next;
                }
            }
        }
    }
    return $result_hr;
}

sub beside_zero {
    my $num = shift;
    if ($num < 0){
        return -1;
    }elsif($num > 0){
        return 1;
    }else{
        return 0;
    }
}

1;

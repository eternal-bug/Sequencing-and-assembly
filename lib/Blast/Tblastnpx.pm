# perl
# Date: 2019-10
# Author: eternal-bug
# Email:  zelda_legend@163.com

package Blast::Tblastnpx;
use File::Basename;
use IPC::Cmd qw/can_run run/;
use File::Spec;
use File::Func;

my @amino_acid = qw/A R D C Q E H I G N L K M F P S T W Y V */;  # 20 amino
my @basic = qw/A G T C/;  # 4 n

my %blast_type_argument = (
    blastn   => "F",
    blastp   => "T",
    tblastn  => "F",
    blastx   => "T",
);

my %query_sbjct = (
    n => {n=>"blastn", p=>"blastx"},
    p => {n=>"tblastn",p=>"blastp"},
);

my %blast_version = (
    n => {formatdb=>"n",makeblastdb=>"nucl"},
    p => {formatdb=>"p",makeblastdb=>"prot"},
);

# ==========================================================================================================================

sub log_error {
    my $info = shift;
    print STDERR $info;
}

sub getfile{
    my ($input_fasta,$input_database,$out) = @_;
    my ($input_type,$database_type);
    
    # judge the file 
    open $INPUT_fh,"<","$input_fasta" or die "Can't open file : $!\b";
    $input_type = &judge_file_type($INPUT_fh);
    close $INPUT_fh;
    
    open my $DATABASE_fh,"<","$input_database" or die "Can't open file : $!\b";
    $database_type = &judge_file_type($DATABASE_fh);
    close $DATABASE_fh;
    
    # blasting
    &processing_blast($input_fasta,$input_database,$input_type,$database_type,$out);
}

sub judge_file_type{
    my $file_handle = shift;
    my $input_type;
    while(my $read = <$file_handle>){
        if(index($read,">")==0){
            $read = <$file_handle>;
            while($read =~ m/^\s*$/){$read = <$file_handle>};
            my @match = grep {index(uc(substr($read,0,20)),$_) != -1} @amino_acid;  
            if(scalar(grep {!m/[AGTCNagtcn]/} @match) > 5){
                $input_type = 'p';  # p is protein
                last;
            }else{$input_type = 'n';last;}  # n is nucleic acid
        }
    }
    return $input_type;
}

sub processing_blast{
    my ($input_fasta,$input_database,$input_type,$database_type,$out) = @_;
    &allblast($input_fasta,$input_database,$query_sbjct{$input_type}{$database_type},$out);
}

sub format{
    my ($input_fasta,$input_database,$format_type,$blast_path) = @_;
    
    # format
    my $formate_pro = "formatdb"; 
    if(run_check($formate_pro)){
        1;
    }elsif(run_check("makeblastdb")){ 
        $formate_pro = "makeblastdb";
    }else{ 
        $formate_pro = "./blast/formatdb";
    }
    
    # read the config
    my $configure = "";
    if ($formate_pro eq 'makeblastdb'){
        open my $formate_cog,"<","./blast+/makeblastdb.txt" or warn "can't open configure file!"
                                                               and $formate_pro = "./blast/formatdb";
        $configure .= "makeblastdb";
        my $readline;
        while($readline = <formate_cog>){
            $readline =~ s/\r?\n//;
            
            if($readline =~ /^#/){
                next;
            }else{
                my @list = split /\s+/,$readline;
                map {
                        my $read = $_;
                        if($read =~ m/^\$(.+)/){
                            my $var = eval($read);
                            my $str = $1;
                            if(defined $blast_version{$format_type}{$str}){
                                $configure .= q{ } . $blast_version{$format_type}{$str};
                            }else{
                                $configure .= q{ } . $var;
                            }
                        }else{
                            $configure .= q{ } . $read;
                        }
                    } @list;
            }
        }
    }    
    
    my ($data_name,$data_path) = File::Basename::fileparse($input_database);
    

    opendir my $dic_fh,"$data_path" or die "Can't open the dictionary($input_database) : $!";
    my @file_list = readdir ($dic_fh);
    my $format_file_suffix = qr(nhr|nin|nsd|nsi|nsq);
    
    if(scalar (grep {m/$data_name\.$format_file_suffix/} @file_list) < 5){
        my $error = qr/\[NULL_Caption\]/o;
        log_error "===> Start to format database file!\n";

        open my $formatdb_out , "formatdb -i $input_database -p $format_type -a F -o T 2>&1 |";
        local $/ = undef;
        my $capture_error = <$formatdb_out>;
        if( $capture_error =~ m/$error/){
            log_error "===> format database fail!Please check the input database file path!\n";
            log_error sprintf("ERROR information is %s \n",$test);
            exit;
        }
        log_error sprintf("===> Database <%s> had been formated\n",$data_name);
    }else{
        log_error sprintf("===> Database <%s> had been formated\n",$data_name);
    }   
}

sub allblast{
    my ($input_fasta,$input_database,$blast_type,$out) = @_;
    &format($input_fasta,$input_database,$blast_type_argument{$blast_type},$blast_path);


    my $blast_out;
    if($out){
        $blast_out = $out;
    }else{
        $blast_out = "./";
    }
    my $tee_out_dir      = "$blast_out/blast_result";
    my $tee_out_file     = File::Basename::basename($input_fasta) . File::Basename::basename($input_database) . ".txt";
    my $tee_out_path = File::Spec->catdir($tee_out_dir,$tee_out_file);
    File::Func::new_bulit_dic($tee_out_dir);
    

    log_error sprintf("===> Start to %s\n",$blast_type);
    mkdir ($tee_out_dir) unless (-e $tee_out_dir);

    open my $out_file_fh,">",$tee_out_path;

    my $cmd = "blastall -p $blast_type -i $input_fasta -d $input_database -m 8";

    log_error $cmd."\n";


    my $fruit = readpipe $cmd;
    print { $out_file_fh } $fruit;
    if(wantarray){
        return ($fruit,$blast_type);
    }else{
        return $fruit || "";
    }
}

sub run_check{
    my $task = shift;
    my $full_path = IPC::Cmd::can_run($task) or die "Can't process $task , you should install $task...\n";
    return $full_path;
}

1;

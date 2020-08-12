package Read::Fasta;
use strict;
use warnings;
use List::Util qw/first/;


sub judge_multi_or_single{
    my ($input,$process) = @_;
    open my $file_fh,"<","$input" or die 'there is no file!';
    local $/ = undef;
    my $temp = <$file_fh>;
    my $number = ($temp =~ s/\n>//) // 0;
    if ($number > 0){
        require "$process/lib/split_fasta.pm";
        my $split_dic = split_fasta->split($input);
        return &get_dic_file($split_dic,"fasta");
    }else{
        return $input;
    }
}


sub judge_dic_file{
    my $input = shift;
    my $file_type = shift;

    my @file_list;
    if(-f $input){
        push @file_list,$input;
    }elsif(-d $input){
        @file_list = get_dic_file($input,$file_type);
    }else{
        die "You enter the fasta file path is ERROR!Please check!";
    }

    unless(scalar(@file_list) > 0){
        die "There isn't fasta file in <$input> dictionary!";
    }else{
        return \@file_list;
    }
}


sub get_dic_file{
    my ($dic_name,$file_type) = @_;

    my @list = ();
    my @return_list = ();

    $file_type =qr/$file_type/i;
    if (!$file_type){$file_type = '\w+'};
    my $temp;
    opendir my $dic_fh,"$dic_name" or die "Can't open the dictionary($dic_name) : $!";
    @list = readdir ($dic_fh);
    for (@list){
        if(-d $_ ){next};
        if(m/^\.+$/){next};
        if(m/\.${file_type}$/){
            $temp = $dic_name ."/". $_;
            push @return_list, $temp;
        }
    }
    closedir $dic_fh;
    return @return_list;
}

1;

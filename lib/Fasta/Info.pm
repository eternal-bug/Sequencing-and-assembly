package Fasta::Info;
use strict;
use warnings;
use List::Util qw/first/;


sub fasta_length{
    my $path = shift;
    my ($title,%hash); 
    open READ,"<","$path" or die "Can't open file $path\n";
    my $read;
    while($read = <READ>){
        $read =~ s/\r?\n$//;
        if($read =~ m/^>(\S+)\s*/){
            $title = $1;
            $hash{$title} = 0;
        }else{
            $hash{$title} += length($read);
        }
    }
    close READ;
    return {%hash};
}

sub store_fasta {
    my $fasta_file = shift;
    my %hash;
    my $title;
    open READ,"<","$fasta_file" or die "Can't open file $fasta_file\n";
    while(<READ>){
        chomp;
        s/^\s+//;
        if(m/>(.+?)\s*$/){
            $title = $1;
            $hash{$title} = "";
        }elsif(m/^[ATGCNatgcn]/){
            $hash{$title} .= $_;
        }
    }
    close READ;
    return {%hash};
}


sub title_to_sequence{
    my $path = shift;
    my $title_list_lr = shift;
    open my $file,"<","$path" or die "<$path> can't be opened! please!";
    my $readline;
    my $flag = 0;
    my %hash; 
    my $title = "";
    while($readline = <$file>){
        chomp($readline);
        if($flag){
            $hash{$title} .= $readline;
        }

        if(index($readline,">")==0){
            $flag = 0;
            if($title = first { $readline =~ m#>\s*\Q$_\E\s*$# } @$title_list_lr){
                $hash{$title} = "";
                $flag = 1;
            }
        }else{
            $flag = 0;
        }
    }
    return {%hash};
}


1;

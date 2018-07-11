package ReadFasta;
use strict;
use warnings;

# 判断文件中是否含有多个fasta序列
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

# 用来判断输入的是文件还是文件夹
sub judge_dic_file{
	my $input = shift;
	my @file_list;
	if(-f $input){
		push @file_list,$input;
	}elsif(-d $input){
		@file_list = &get_dic_file($input,"fas|fa|fasta");
	}else{die "You enter the fasta file path is ERROR!Please check!"}
	unless(scalar(@file_list) > 0){
		die "There isn't fasta file in <$input> dictionary!";
	}else{
		return (\@file_list);
	}
}

#获取文件夹中相应格式的文件,"路径"，"文件格式"
sub get_dic_file{
	my @list = ();
	my @return_list = ();
	my $dic_name = shift;
    my $file_type = shift || '\w+';
	$file_type =qr/$file_type/i;
	my $temp;
	if(-d $dic_name){
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
	}elsif(-f $dic_name){
		push @return_list, $dic_name;
	}
	return @return_list;
}

# 得到fasta文件的序列长度和标签头信息
sub get_fasta_info{
	my $path = shift;
	my ($title,%hash);  # 哈西用来存储 标签名=>对应序列长度
	open READ,"<","$path" or die "Can't open file $path\n";
	while(<READ>){
	chomp;
	s/^\s+//;
	if(index($_,">") == 0){
		tr/>//d;
		$title = $_;
		$hash{$title} = 0;
	}elsif(m/^[ATGCNatgcn]/){$hash{$title} += length($_)}
	}
	close READ;
	return {%hash};
}

1;

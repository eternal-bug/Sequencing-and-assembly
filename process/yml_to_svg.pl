#!usr/bin/perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$FindBin::Bin/lib";
use SVG;
use YAML::Syck qw/LoadFile Dump/;   # 读取yml或者yaml文件进入程序
use Data::Dumper qw/Dumper/;
use Getopt::Long;
use File::Basename;
use File::Path qw/mkpath/;
use ReadFasta qw/get_dic_file/;

my $arguments = GetOptions(
    "y|yml=s"       =>\(my $yml_path),
    "o|out=s"       =>\(my $out_path),
    "h|help"        =>\(my $help),
);

my $file_path = $yml_path;
my @file_list = &ReadFasta::get_dic_file($file_path,"yml|yaml");

for my $file (@file_list){
    my $data_hr = YAML::Syck::LoadFile($file);
    my $svg_object = &svg_graph($data_hr);
	
    # 新建文件夹
    my $dir_basename  = File::Basename::basename($file =~ s#(/.+?)/.+$#$1#r);
    my $base_basename = File::Basename::basename($file);

    &new_built_path ($out_path);
	
	&save_svg($svg_object,$dir_basename.".svg",$out_path);
}

sub save_svg{
	my $svg_obj = shift;
	my $svg_name = shift;
	my $output_path = shift;
	
	if(ref $svg_obj){
		my $str = $svg_obj->SVG::xmlify(
                        -namespace => "svg",
                        -pubid => "-//W3C//DTD SVG 1.0//EN",
                        -inline   => 1
                        );
        open my $file_fh,">","./$output_path/$svg_name" or die $!;
        print {$file_fh} $str;
	}
}

sub new_built_path {   # 新建文件夹，可以新建多层级的文件夹
    my $path = shift;
    if(-d "$path"){
        return 0;
    }else{
        (File::Path::mkpath ("$path",0,0755) && return 1) || return undef;
    }
}

sub whether_live {  # 判断文件是否存在
	my $path = shift;
	my $path_temp = $path;
	my $n = 0;
	LABEL:
	if(-e $path_temp){
		$n++;
		if(-f $path_temp){
	    	$path_temp = $path . "($n)";
		}
	}else{
		return undef;
	}
}

sub svg_graph {
    my $hash_r = shift;
    # title  =>  '1-456,786-999';
    # 序列的名称  =>   可信的范围

    #           $width 
    # ——————————————————————————————
    #       |                         $row_height
    # ******|----------------------- 缩放比例 + 比例尺
    #       |                                       
    # ******|----------------------- 序列名称 + 序列图线
    #       |
    # ——————————————————————————————

    # 决定画幅的高度
    my $row_height = 20;
    my $count = scalar(keys %$hash_r);
    my $height = $row_height * (($count - 1) + 4);
    # 决定画幅的宽度
    my $word_region = 100;
    my $graph_region = 1000;
    my $spill_volume = 100; # 溢出量，防止溢出
    my $width = $word_region + $graph_region;

    # 得到序列中长度最长的序列的长度
    my $max_len = 0;
    for my $title (keys %$hash_r){
        my $len = &get_len($title);
        $max_len = $len if $len > $max_len;
    }

    # 当前打印的行数
    my $row_number = 1;

    # 留白的宽度
    my $blank_width = 10;

    my $svg = SVG->new(
                    width  => $width + $spill_volume,
                    height => $height,
                    );

    # 生成线段样式
    my $line_group1_black_2 = &new_svg_line_group($svg,"black","group1_l",2);
    my $line_group1_black_8 = &new_svg_line_group($svg,"grey","group2_l_8",8);
    my $line_group1_black_05 = &new_svg_line_group($svg,"black","group1_l_0_5",0.5);
    my $line_group2_red_2  = &new_svg_line_group($svg,"red","group2_r_l",8);
    my $line_group2_orange_2 = &new_svg_line_group($svg,"orange","group2_o_l",8);
    my $line_group2_green_2 = &new_svg_line_group($svg,"green","group2_g_l",8);
    my $color_hr = {
        1 => $line_group2_red_2,
        2 => $line_group2_orange_2,
        3 => $line_group2_green_2,
    };
    # 生成文字的样式
    my $word_group1_black = &new_svg_word_group($svg,"black","group1_w",10);

    # 生成比例尺
    $word_group1_black->text(x=>$blank_width,y=>$row_height * $row_number + 5)->cdata("w:$width-h:$height");
    $line_group1_black_2->line(x1=>$word_region + $blank_width,y1=>$row_height * $row_number,
                             x2=>$width - $blank_width ,     y2=>$row_height * $row_number);
    # 最长的线段的长度
    my $image_scale_len = ($width - $blank_width) - ($word_region + $blank_width);

    # 线段相对比例
    my $percent = $image_scale_len / $max_len;
    my $average_length = $max_len / 100;

    for my $i (0..100){
        if ( $i % 10 == 0){
            $line_group1_black_2->line(
                                        x1=>int($word_region + $blank_width + ($image_scale_len / 100) * $i),
                                        y1=>$row_height * $row_number,
                                        x2=>int($word_region + $blank_width + ($image_scale_len / 100) * $i),
                                        y2=>$row_height * $row_number + 10,
                                        );
            $word_group1_black->text(x=>$word_region + $blank_width + ($image_scale_len / 100) * $i,
                                     y=>$row_height * ($row_number + 1) + 5)->cdata(sprintf "%d",$average_length * $i);
        }else{
            $line_group1_black_05->line(
                                        x1=>int($word_region + $blank_width + ($image_scale_len / 100) * $i),
                                        y1=>$row_height * $row_number,
                                        x2=>int($word_region + $blank_width + ($image_scale_len / 100) * $i),
                                        y2=>$row_height * $row_number + 5,
                                        );
        }
    }
    $row_number++;

    # 进行绘画
    for my $title (sort sort_by_number keys %$hash_r){
        # 行数递增
        $row_number++;
        # 先绘制标题行
        $word_group1_black->text(x=>$blank_width,y=>$row_height * $row_number + 5)->cdata("$title");

        # 得到该序列的总长度信息
        my $length = &get_len($title);

        # 绘制底图
        $line_group1_black_8->line(
                                    x1=>$word_region + $blank_width,
                                    y1=>$row_height * $row_number,
                                    x2=>$word_region + $blank_width + $percent * $length,
                                    y2=>$row_height * $row_number,
                                    );

        # 对该行的序列进行绘制
        my @scale_raw = split /,/,$hash_r->{$title};
        my @scale_cooked = map {[split /-/,$_]} @scale_raw;

        for my $scale_lr (@scale_cooked){
            if(exists $scale_lr->[0]){
                # 检查差值
                my $color = "";
                my $occupy_percent = ($scale_lr->[1] - $scale_lr->[0]) / $length;
                if($occupy_percent > 0.5){
                    $color = $color_hr->{3};
                }elsif($occupy_percent > 0.2){
                    $color = $color_hr->{2};
                }else{
                    $color = $color_hr->{1};
                }
                # 绘制叠加图
                $color->line(
                                            x1=>$word_region + $blank_width + $percent * $scale_lr->[0],
                                            y1=>$row_height * $row_number,
                                            x2=>$word_region + $blank_width + $percent * $scale_lr->[1],
                                            y2=>$row_height * $row_number,
                                            );
            }
        }
    }
    return $svg;
}

sub get_len {
    my $title_name = shift;
    # 格式为infile_0/1/0_1234 (1234就为序列的长度)
    return $1 if $title_name =~ m/(\d+)$/;
}

sub new_svg_line_group {  # 新建线的风格
    my ($svg_object,$color,$group_name,$width) = @_;
    if(defined ref $svg_object){
        return $svg_object->group(
                                    id=>$group_name,
                                    style=>{stroke=>$color,'stroke-width' => $width || 2},
                                );
    }
}

sub new_svg_word_group {   # 新建文字的风格
    my ($svg_object,$color,$group_name,$width) = @_;
    if(defined ref $svg_object){
        return $svg_object->group(
                                    id=>$group_name,
                                    style=>{
                                        'stroke'       => $color,
                                        'font'         => [ qw( Arial Helvetica sans ) ],
                                        'font-size'    => $width || 10,
                                        'fill'         => $color,
                                        },
                                );
    }
}

sub sort_by_number{
    # 编号格式为 >infile_0/1/0_1234
    #                     ^    ^
    #                     |    |
    #                    编号 长度
    $a =~ s#.+?/(\d+)/.+#$1#r <=> $b =~ s#.+?/(\d+)/.+#$1#r;
}

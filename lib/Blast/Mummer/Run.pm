package Blast::Mummer::Run;
use IPC::Cmd qw/can_run/;

sub log_error {
    my $info = shift;
    print STDERR $info;
}

sub get_file {
    my ($input_query,$input_sbjct,$arguments) = @_;
    &nucmer($input_query,$input_sbjct,$arguments_hr);
}

sub nucmer{
    my ($input_query,$input_sbjct,$arguments) = @_;
    
    &run_check("nucmer");
    
    my $cmd = "perl" . q{ } . "nucmer" . q{ };
    for (keys %$arguments){
        $cmd .= $_ . q{ } . $arguments->{$_} . q{ };
    }
    $cmd .= $input_query . q{ };
    $cmd .= $input_sbjct . q{ };
    &run_nucmer($cmd);
}

sub run_nucmer{
    my $cmd = shift;
    &log_error($cmd."\n");
    my $fruit = readpipe $cmd;
    return $fruit;
}

sub run_check{
    my $task = shift;
    my $full_path = IPC::Cmd::can_run($task) or die "Can't process $task , you should install $task...\n";
    return $full_path;
}

1;

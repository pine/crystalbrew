use strict;
use warnings;
use utf8;


use t::Util;
BEGIN { require 'crystalbrew' }

use Capture::Tiny qw/capture/;


subtest basic => sub {
    no warnings 'redefine';
    my $called_local = 0;
    local *Crystalbrew::_cmd_ls = sub { $called_local = 1 };

    my $called_remote = 0;
    local *Crystalbrew::_cmd_ls_remote = sub { $called_remote = 1 };


    my $self = create_crystalbrew;
    my ($stdout, $stderr) = capture { $self->_cmd_ls_all };

    ok $stdout =~ /remote:/;
    ok $stdout =~ /local:/;

    ok $called_local;
    ok $called_remote;
};

done_testing;

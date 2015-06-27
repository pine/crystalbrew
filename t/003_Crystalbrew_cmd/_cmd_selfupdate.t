use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $called = 0;
    local *Crystalbrew::fetch_crystalbrew = sub { $called = 1 };

    my $self = create_crystalbrew;
    my ($stdout, $stderr) = capture { $self->_cmd_selfupdate };

    ok $stdout =~ /Update/;
    ok $stdout =~ /successful/;
};

done_testing;

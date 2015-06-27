use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    no warnings 'redefine';

    my $self = create_crystalbrew;

    subtest version => sub {
        my $called = 0;
        local *Crystalbrew::clean = sub { $called = 1 };

        my ($stdout, $stderr) = capture { $self->_cmd_clean(['v0.7.4']) };

        ok $called;
        ok $stdout =~ /clean/;
        ok $stdout =~ /v0\.7\.4/;
    };

    subtest all => sub {
        my $called = 0;
        local *Crystalbrew::clean = sub { $called = 1 };

        my ($stdout, $stderr) = capture { $self->_cmd_clean(['all']) };

        ok $called;
        ok $stdout =~ /clean/;
        ok $stdout =~ /all/;
    };
};

done_testing;

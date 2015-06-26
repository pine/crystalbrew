use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    my $self = create_crystalbrew;

    subtest default => sub {
        my $called = 0;
        local *Crystalbrew::_cmd_test = sub {
            my ($self, $args) = @_;

            $called = 1;

            is $args->[0], 'arg1';
            is $args->[1], 'arg2';
        };

        $self->run('test', ['arg1', 'arg2']);
        ok $called;
    };

    subtest help => sub {
        no warnings 'redefine';

        my $called = 0;
        local *Crystalbrew::_cmd_help = sub { $called = 1 };

        $self->run('unknown-command', []);
        ok $called;
    };
};

done_testing;

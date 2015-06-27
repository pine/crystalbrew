use strict;
use warnings;
use utf8;

# Hook for `system` function
our $system = \CORE::system;
BEGIN {
    *CORE::GLOBAL::system = sub { &$system(@_) };
}

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $called_find = 0;
    local *Crystalbrew::find_available_version = sub {
        my ($self, $version) = @_;
        $called_find = 1;

        ok $version, 'v0.7.4';
        $version;
    };

    my $called_system = 0;
    $system = sub {
        $called_system = 1;

        ok shift, 'test --flag';
        ok
            index($ENV{PATH}, 't/tmp/.crystalbrew/crystal/v0.7.4/bin') > -1,
            'should include crystal path that is specialized version';
    };

    my $self = create_crystalbrew;
    $self->_cmd_exec(['v0.7.4', '--', 'test --flag']);


    ok $called_find;
    ok $called_system;
};

done_testing;

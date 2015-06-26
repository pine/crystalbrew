use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    no warnings 'redefine';

    my $initialized = 0;
    local *Crystalbrew::init = sub { $initialized = 1 };

    my $crystalbrew = Crystalbrew->new(test_key => 'test_value');

    isa_ok $crystalbrew, 'Crystalbrew';
    is $crystalbrew->{test_key}, 'test_value';
    ok $initialized, 'should call `init` method';
};

done_testing;

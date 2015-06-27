use strict;
use warnings;
use utf8;


use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $called = 0;
    local *Crystalbrew::_cmd_list = sub { $called = 1 };

    my $self = create_crystalbrew;
    $self->_cmd_ls;

    ok $called;
};

done_testing;

use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    my $github = Crystalbrew::GitHub->new(test_key => 'test_value');
    is $github->{test_key}, 'test_value', 'should initialize';
};

done_testing;

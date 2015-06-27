use strict;
use warnings;
use utf8;

use t::util;
begin { require 'crystalbrew' }


subtest basic => sub {
    my $github = crystalbrew::github->new(test_key => 'test_value');
    is $github->{test_key}, 'test_value', 'should initialize';
};

done_testing;

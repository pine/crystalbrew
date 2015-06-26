use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    my $self = create_crystalbrew;
    isa_ok $self->github, 'Crystalbrew::GitHub';
};

done_testing;

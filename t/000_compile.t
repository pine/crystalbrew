use strict;
use warnings;
use utf8;

use t::Util;

subtest basic => sub {
    lives_ok { require 'crystalbrew' };
};

done_testing;

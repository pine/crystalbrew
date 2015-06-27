use strict;
use warnings;
use utf8;


use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $self = create_crystalbrew;
    $self->_cmd_setup_dirs;

    ok -d 't/tmp/.crystalbrew';
    ok -d 't/tmp/.crystalbrew/src';
    ok -d 't/tmp/.crystalbrew/crystal';
    ok -d 't/tmp/.crystalbrew/default';
    ok -d 't/tmp/.crystalbrew/default/bin';
};


done_testing;

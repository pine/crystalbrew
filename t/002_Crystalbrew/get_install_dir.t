use strict;
use warnings;
use utf8;

use File::Path qw/rmtree/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    my $self = create_crystalbrew;

    rmtree 't/tmp/.crystalbrew/crystal';
    ok not -d 't/tmp/.crystalbrew/crystal';

    $self->get_install_dir;

    ok -d 't/tmp/.crystalbrew/crystal';
};

done_testing;

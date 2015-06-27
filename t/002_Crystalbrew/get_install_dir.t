use strict;
use warnings;
use utf8;

use File::Path qw/rmtree/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    setup_dirs;
    my $self = create_crystalbrew;

    ok not -e 't/tmp/.crystalbrew/crystal';

    $self->get_install_dir;

    ok -e 't/tmp/.crystalbrew/crystal';
};

done_testing;

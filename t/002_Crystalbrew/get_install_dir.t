use strict;
use warnings;
use utf8;

use File::Path qw/rmtree mkpath/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    subtest default => sub {
        setup_dirs;
        my $self = create_crystalbrew;

        mkpath 't/tmp/.crystalbrew/crystal';
        ok -e 't/tmp/.crystalbrew/crystal';

        $self->get_install_dir;

        ok -e 't/tmp/.crystalbrew/crystal';
    };

    subtest mkdir => sub {
        setup_dirs;
        my $self = create_crystalbrew;

        ok not -e 't/tmp/.crystalbrew/crystal';

        $self->get_install_dir;

        ok -e 't/tmp/.crystalbrew/crystal';
    };
};

done_testing;

use strict;
use warnings;
use utf8;

use Cwd qw/abs_path/;
use File::Touch;
use File::Path qw/rmtree mkpath/;
use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


sub setup {
    setup_dirs;
    symlink 't/Util.pm', 't/tmp/.crystalbrew/current';
    mkpath 't/tmp/.crystalbrew/crystal/v0.7.4/bin';
    touch 't/tmp/.crystalbrew/crystalbrew';
}


subtest basic => sub {
    no warnings 'redefine';
    local *Crystalbrew::find_available_version = sub { $_[1] };

    setup;
    my $self = create_crystalbrew;

    my ($stdout, $stderr) = capture {
        $self->_cmd_use(['v0.7.4']);

        ok -l 't/tmp/.crystalbrew/current';

        is
            abs_path(readlink('t/tmp/.crystalbrew/current')),
            abs_path('t/tmp/.crystalbrew/crystal/v0.7.4');

        is
            abs_path(readlink('t/tmp/.crystalbrew/crystal/v0.7.4/bin/crystalbrew')),
            abs_path('t/tmp/.crystalbrew/crystalbrew');
    };

    ok $stdout, 'v0.7.4';
};

done_testing;

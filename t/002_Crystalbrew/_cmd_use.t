use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    no warnings 'redefine';
    local *Crystalbrew::find_available_version = sub { $_[1] };

    setup_dirs;
    my $self = create_crystalbrew;

    my ($stdout, $stderr) = capture {
        $self->_cmd_use(['v0.7.4']);
    };

    warn Dumper( $stdout );
    pass;
};

done_testing;

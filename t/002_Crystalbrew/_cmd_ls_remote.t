use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';
    local *Crystalbrew::GitHub::fetch_releases = sub {
        [
            +{ tag_name => 'v0.6.0' },
            +{ tag_name => 'v0.7.0' },
            +{ tag_name => 'v0.7.1' },
        ];
    };

    my $called_normalize = 0;
    local *Crystalbrew::normalize_version = sub {
        my ($self, $version) = @_;

        $called_normalize = 1;
        $version;
    };

    my $called_print = 0;
    local *Crystalbrew::print_remote_versions = sub {
        my ($self, $versions) = @_;

        $called_print = 1;
        cmp_deeply $versions, ['v0.6.0', 'v0.7.0', 'v0.7.1' ];
    };


    my $self = create_crystalbrew;
    $self->_cmd_ls_remote;

    ok $called_normalize;
    ok $called_print;
};

done_testing;

use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';
    local *Crystalbrew::Utils::sort_version = sub { shift };

    subtest installed => sub {
        local *Crystalbrew::get_local_version = sub {
            [
                qw/
                v0.6.0 v0.6.1
                v0.7.0 v0.7.1 v0.7.2 v0.7.3 v0.7.4
                /
            ]
        };

        my $self = create_crystalbrew;
        my ($stdout, $stderr) = capture { $self->_cmd_list };

        ok $stdout =~ /v0\.6\.0/;
        ok $stdout =~ /v0\.7\.0/;
        ok $stdout =~ /v0\.7\.4/;

        ok $stdout !~ /not\ installed/;
    };

    subtest 'not installed' => sub {
        local *Crystalbrew::get_local_version = sub { [] };

        my $self = create_crystalbrew;
        my ($stdout, $stderr) = capture { $self->_cmd_list };

        ok $stdout =~ /not\ installed/;
    };

    subtest current => sub {
        local *Crystalbrew::get_local_version = sub { ['v0.7.4'] };
        local *Crystalbrew::get_current_version = sub { 'v0.7.4' };

        my $self = create_crystalbrew;
        my ($stdout, $stderr) = capture { $self->_cmd_list };

        ok $stdout !~ /not\ installed/;
        ok $stdout =~ /current:\ v0\.7\.4/;
    };
};

done_testing;

use strict;
use warnings;
use utf8;

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

    local *Crystalbrew::normalize_version = sub { $_[1] };
    local *Crystalbrew::get_current_version= sub { 'none' };
    local *Crystalbrew::use_default = sub { };

    setup;
    my $self = create_crystalbrew;

    my ($stdout, $stderr) = capture {
        $self->_cmd_uninstall(['v0.7.4']);
    };

    my $is_deleted = not -d 't/tmp/.crystalbrew/crystal/v0.7.4';
    ok $is_deleted, 'should delete installed directory';

    ok $stdout =~ /uninstalled/, 'shoud show succeeded message';
    ok $stdout =~ /v0\.7\.4/, 'should show uninstalled version';
};

done_testing;

use strict;
use warnings;
use utf8;

use File::Touch;
use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    local *Crystalbrew::_cmd_setup_dirs = sub { };
    local *Crystalbrew::fetch_crystalbrew = sub {
        touch 't/tmp/.crystalbrew/crystalbrew';
    };

    my $self = create_crystalbrew;
    my ($stdout, $stderr) = capture { $self->_cmd_setup };

    ok -x 't/tmp/.crystalbrew/crystalbrew', 'should be able to execute';

    ok $stdout =~ /crystalbrew/;
    ok $stdout =~ /path/;
    ok $stdout =~ /export/;
    ok $stdout =~ /t\/tmp\/\.crystalbrew\/current\/bin/;
};

done_testing;

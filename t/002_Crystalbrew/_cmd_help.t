use strict;
use warnings;
use utf8;

use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    my $self = create_crystalbrew;

    my ($stdout, $stderr) = capture { $self->_cmd_help };

    ok $stdout =~ /Usage/;
    ok $stdout =~ /Example/;
    ok $stdout =~ /crystalbrew/;
};

done_testing;

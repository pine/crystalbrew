use strict;
use warnings;
use utf8;

use Cwd qw/abs_path/;

use t::Util;
BEGIN { require 'crystalbrew' }

subtest basic => sub {
    my $self = create_crystalbrew;

    is abs_path($self->{src_dir}), abs_path('t/tmp/.crystalbrew/src');
    is abs_path($self->{crystal_dir}), abs_path('t/tmp/.crystalbrew/crystal');
    is abs_path($self->{current}), abs_path('t/tmp/.crystalbrew/current');
    is abs_path($self->{default_dir}), abs_path('t/tmp/.crystalbrew/default');
    is abs_path($self->{alias_file}), abs_path('t/tmp/.crystalbrew/alias');
};

done_testing;

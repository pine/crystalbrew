use strict;
use warnings;
use utf8;

use File::Basename;
use Cwd qw/abs_path/;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    can_ok 'main', qw/main/;
};

subtest mock => sub {
    no warnings 'redefine';

    local *Crystalbrew::new = sub {
        my ($class, %opt) = @_;
        bless +{ %opt } => $class;
    };

    local *Crystalbrew::run = sub { shift };

    # -------------------------------------------------------------------------

    subtest crystalbrew_url => sub {
        ok main::main->{crystalbrew_url} =~ /githubusercontent/, 'should be repository URL';
    };

    subtest brew_dir => sub {
        subtest '$ENV{CRYSTALBREW_ROOT}' => sub {
            local $ENV{CRYSTALBREW_ROOT} = abs_path('t/tmp');
            is main::main->{brew_dir}, abs_path('t/tmp');
        };

        subtest '$ENV{HOME}' => sub {
            local $ENV{CRYSTALBREW_ROOT};
            local $ENV{HOME} = abs_path('t/tmp');
            is main::main->{brew_dir}, abs_path('t/tmp/.crystalbrew');
        };
    };

    subtest gitbub_repo => sub {
        ok main::main->{github_repo} =~ /\w+\/\w+/, 'should format `author`/`repo`';
    };

    subtest fetcher => sub {
        subtest curl => sub {
            local *main::fetcher_type = sub { 'curl' };
            isa_ok main::main->{fetcher}, 'Crystalbrew::Fetcher::Curl';
        };

        subtest wget => sub {
            local *main::fetcher_type = sub { 'wget' };
            isa_ok main::main->{fetcher}, 'Crystalbrew::Fetcher::Wget';
        };
    };
};

done_testing;

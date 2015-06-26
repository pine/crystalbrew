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

    my $new_class;
    my $new_opt;

    local *Crystalbrew::new = sub {
        my ($class, %opt) = @_;
        $new_class = $class;
        $new_opt   = \%opt;

        bless +{} => $class;
    };

    local *Crystalbrew::run = sub { };

    subtest class => sub {
        main::main();
        is $new_class, 'Crystalbrew', 'should be string `Crystalbrew`';
    };

    subtest opt => sub {
        subtest crystalbrew_url => sub {
            main::main();
            ok $new_opt->{crystalbrew_url} =~ /githubusercontent/, 'should be repository URL';
        };

        subtest brew_dir => sub {
            subtest '$ENV{CRYSTALBREW_ROOT}' => sub {
                local $ENV{CRYSTALBREW_ROOT} = abs_path('t/tmp');

                main::main();
                is $new_opt->{brew_dir}, abs_path('t/tmp');
            };

            subtest '$ENV{HOME}' => sub {
                local $ENV{CRYSTALBREW_ROOT};
                local $ENV{HOME} = abs_path('t/tmp');

                main::main();
                is $new_opt->{brew_dir}, abs_path('t/tmp/.crystalbrew');
            };
        };
    };
    #     ok $new_opt->{crystalbrew_url} =~ /githubusercontent/, 'should be repository URL';
    #     ok $new_opt->{crystalbrew_url} =~ /githubusercontent/, 'should be repository URL';
    # };
    # my $brew_dir        = abs_path($ENV{'NODEBREW_ROOT'} || $ENV{'HOME'} . '/.crystalbrew');
};

done_testing;

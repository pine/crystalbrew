use strict;
use warnings;
use utf8;

# Hook for `system` function
our $system = \CORE::system;
BEGIN {
    *CORE::GLOBAL::system = sub { &$system(@_) };
}

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $called_find = 0;
    local *Crystalbrew::find_available_version = sub {
        $called_find = 1;
        ok $_[1], 'v0.7.4';
    };

    my $called_system = 0;
    $system = sub {
        $called_system = 1;
        ok shift, 'test --flag';
    };

    my $self = create_crystalbrew;
    $self->_cmd_exec(['v0.7.4', '--', 'test --flag']);


    ok $called_find;
    ok $called_system;
};

done_testing;

# sub _cmd_exec {
#     my ($self, $args) = @_;
#
#     my $version = $self->find_available_version(shift @$args);
#
#     $ENV{PATH} = $self->get_install_dir . "/$version/bin:$ENV{PATH}";
#
#     shift @$args if $args->[0] eq '--';
#     my $command = join ' ', @$args;
#
#     system $command;
# }

package t::Util;

use strict;
use warnings;
use utf8;

use Exporter 'import';
use Data::Dumper;


use Test::More;
use Test::Deep;
use Test::Deep::Matcher;
use Test::Exception;

sub create_crystalbrew {
    my (%opt) = @_;
    $opt{fetcher}     ||= Crystalbrew::Fetcher::Wget->new;
    $opt{github_repo} ||= 'author/repo';
    $opt{brew_dir}    ||= 't/tmp/.crystalbrew';

    Crystalbrew->new(%opt);
}

sub setup_dirs {
    require File::Path;
    import File::Path qw/rmtree mkpath/;

    rmtree('t/tmp/.crystalbrew');
    mkpath('t/tmp/.crystalbrew');
}

sub do_e2e_test {
    my $code = shift;

    require File::Path;
    import File::Path qw/rmtree mkpath/;

    require Cwd;
    import Cwd qw/abs_path/;

    local $ENV{HOME} = abs_path('t/tmp/home');
    rmtree($ENV{HOME});
    mkpath($ENV{HOME});

    &$code();
}

our @EXPORT = (
    qw/create_crystalbrew setup_dirs do_e2e_test/,

    @Data::Dumper::EXPORT,

    @Test::More::EXPORT,
    @Test::Deep::EXPORT,
    @Test::Deep::Matcher::EXPORT,
    @Test::Exception::EXPORT,
);

1;

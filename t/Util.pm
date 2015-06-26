package t::Util;

use strict;
use warnings;
use utf8;

use Exporter 'import';
use File::Path qw/rmtree mkpath/;
use Data::Dumper;

use Test::More;
use Test::Deep;
use Test::Deep::Matcher;
use Test::Exception;

sub create_crystalbrew {
    my (%opt) = @_;
    $opt{brew_dir} ||= 't/tmp/.crystalbrew';

    Crystalbrew->new(%opt);
}

sub setup_dirs {
    rmtree 't/tmp/.crystalbrew';
    mkpath 't/tmp/.crystalbrew';
}

our @EXPORT = (
    qw/create_crystalbrew setup_dirs/,

    @Data::Dumper::EXPORT,

    @Test::More::EXPORT,
    @Test::Deep::EXPORT,
    @Test::Deep::Matcher::EXPORT,
    @Test::Exception::EXPORT,
);

1;

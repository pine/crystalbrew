use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    no warnings 'redefine';

    my $called_fetch = 0;
    local *Crystalbrew::Fetcher::Wget::fetch_from_github = sub {
        my ($self, $url) = @_;

        $called_fetch = 1;
        ok $url, 'http://dummy.url/';
    };

    my $fetcher = Crystalbrew::Fetcher->get('wget');
    my $github  = Crystalbrew::GitHub->new(fetcher => $fetcher);

    $github->fetch('http://dummy.url/');
    ok $called_fetch;
};

done_testing;

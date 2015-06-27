use strict;
use warnings;
use utf8;

use t::Util;
BEGIN { require 'crystalbrew' }


subtest basic => sub {
    my $github = Crystalbrew::GitHub->new(github_repo => 'author/repo');
    is $github->base_url, 'https://api.github.com/repos/author/repo/';
};

done_testing;

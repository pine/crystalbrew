use strict;
use warnings;
use utf8;

use t::Util;


do_e2e_test sub {
    my $version = 'v0.7.4';

    is system("./crystalbrew setup"), 0;
    is system("./crystalbrew help"), 0;
    is system("./crystalbrew install $version"), 0;
    is system("./crystalbrew use $version"), 0;
    is system("./crystalbrew exec $version -- pwd"), 0;
    is system("./crystalbrew ls"), 0;
    is system("./crystalbrew ls-remote"), 0;
    is system("./crystalbrew ls-all"), 0;
    is system("./crystalbrew clean $version"), 0;
    is system("./crystalbrew clean all"), 0;
    is system("./crystalbrew uninstall $version"), 0;
    is system("./crystalbrew selfupgrade"), 0;
};

done_testing;

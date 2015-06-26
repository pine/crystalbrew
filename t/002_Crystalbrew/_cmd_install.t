use strict;
use warnings;
use utf8;

use Cwd qw/abs_path/;
use File::Touch;
use File::Path qw/rmtree mkpath/;
use Capture::Tiny qw/capture/;

use t::Util;
BEGIN { require 'crystalbrew' }


sub setup {
    setup_dirs;
    symlink 't/Util.pm', 't/tmp/.crystalbrew/current';
    touch 't/tmp/.crystalbrew/crystalbrew';
}

subtest basic => sub {
    no warnings 'redefine';

    local *Crystalbrew::find_install_version = sub { $_[1] };
    local *Crystalbrew::Utils::system_info = sub { ('linux', 'x64') };
    local *Crystalbrew::Fetcher::Wget::download = sub {
        my ($self, $url, $path) = @_;
        is $url, 'http://dummy.url/crystal-0.7.4-linux.tar.gz';
        is $path, 't/tmp/.crystalbrew/src/v0.7.4/crystal-v0.7.4-linux-x64.tar.gz';
    };
    local *Crystalbrew::GitHub::fetch_release = sub {
        +{
            assets => [
                +{
                    name                 => 'crystal-0.7.4-linux.tar.gz',
                    browser_download_url => 'http://dummy.url/crystal-0.7.4-linux.tar.gz',
                }
            ]
        }
    };
    local *Crystalbrew::Utils::extract_tar = sub {
        my ($tarball_path, $src_dir) = @_;

        is $tarball_path, 't/tmp/.crystalbrew/src/v0.7.4/crystal-v0.7.4-linux-x64.tar.gz';
        is $src_dir, 't/tmp/.crystalbrew/src/v0.7.4';

        mkpath 't/tmp/.crystalbrew/src/v0.7.4/crystal-v0.7.4-1/bin/';
    };

    # -------------------------------------------------------------------------

    setup;
    my $self = create_crystalbrew;

    my ($stdout, $stderr) = capture {
        $self->_cmd_install(['v0.7.4']);
    };

    ok -d 't/tmp/.crystalbrew/crystal/v0.7.4/bin';

    ok $stdout =~ /fetch/;
    ok $stdout =~ /resolve/;
    ok $stdout =~ /v0\.7\.4/;
    ok $stdout =~ /Install successful/;
};

done_testing;

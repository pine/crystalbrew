crystalbrew
-----------

[![Build Status](https://travis-ci.org/pine613/crystalbrew.svg?branch=master)](https://travis-ci.org/pine613/crystalbrew)

[Crystal](http://crystal-lang.org/) version manager.


## Install
One liner curl install.

```
$ curl -L j.mp/crystalbrew | perl - setup
```

Or, download and setup.

```
$ wget j.mp/crystalbrew
$ perl crystalbrew setup
```

Add PATH setting your shell config file (.bashrc or .zshrc).

```
export PATH=$HOME/.crystalbrew/current/bin:$PATH
```

Reload config.

```
$ source ~/.bashrc
```

Confirm.

```
$ crystalbrew help
```

## Usage
Please see help.

```
$ crystalbrew --help
crystalbrew 0.0.1

Usage:
    crystalbrew help                         Show this message
    crystalbrew install <version>            Download and install a <version> (binary file)
    crystalbrew uninstall <version>          Uninstall a version
    crystalbrew use <version>                Use <version>
    crystalbrew list                         List installed versions
    crystalbrew ls                           Alias for `list`
    crystalbrew ls-remote                    List remote versions
    crystalbrew ls-all                       List remote and installed versions
    crystalbrew alias <key> <version>        Set alias to version
    crystalbrew unalias <key>                Remove alias
    crystalbrew clean <version> | all        Remove source file
    crystalbrew selfupdate                   Update crystalbrew
    crystalbrew exec <version> -- <command>  Execute <command> specified <version>

Example:
    # install from binary
    crystalbrew install-binary v0.7.4

```

## Development

Install module for testing.

```
$ carton install
```

Run test.

```
$ carton exec -- prove -lvr
```

If you installed [direnv](https://github.com/zimbatm/direnv), you could run `prove` without prefix.

## Acknowledgement

- [hokaccha](https://github.com/hokaccha)<br />
crystalbrew is based [nodebrew](https://github.com/hokaccha/nodebrew). Thank you.

## Author
Pine Mizune

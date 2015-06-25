crystalbrew
-----------

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

export PATH=$HOME/.crystalbrew/current/bin:$PATH
Reload config.

$ source ~/.bashrc
Confirm.

$ crystalbrew help

## Acknowledgement
crystalbrew is based [nodebrew](https://github.com/hokaccha/nodebrew). Thank you.

## Author
Pine Mizune <pinemz@gmail.com>

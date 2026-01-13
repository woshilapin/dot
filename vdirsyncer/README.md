Installation
============

`vdirsyncer` can be installed with `virtualenv`, preferably with Python3+.

```
virtualenv --python=python3 ~/.virtualenvs/vdirsyncer
```

This will create a usable Python3 installation of `vdirsyncer` completely
contained inside the directory `~/.virtualenvs/vdirsyncer/`.

You can then activate the `virtualenv` by using the following command.

```
source ~/.virtualenvs/vdirsyncer/bin/activate
```

All it does is change the `$PATH` variable to look first inside this
`virtualenv` for binaries.  Note that binaries like `python` and `pip` should
also work without this step of activation.

Once activated (or using the direct binary for `python` or `pip`), you can then
install `vdirsyncer`.

```
pip install vdirsyncer
```

Use
===

To use `vdirsyncer`, you can either launch it with the `virtualenv` version of
`python`’s binary.

```
~/.virtualenvs/vdirsyncer/bin/python ~/.virtualenvs/vdirsyncer/bin/vdirsyncer <option>
```

or activate the `virtualenv` and launch directly the binary.

```
source ~/.virtualenvs/vdirsyncer/bin/activate
vdirsyncer <option>
```

The options are:

- `discover` to look for new configurations
- `sync` to synchronize the data

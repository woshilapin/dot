About `irssi`
=============

To list the available rooms (at least on Freenode), you can use ask to the Alis
service.

    /msg Alis HELP LIST

Then in the window of Alis, you can use the bot as following

    LIST *b2g*

with `b2g` the string you're looking for.

# About `fnotify`
You can get some Gnome notifications when somebody is trying to reach you on
IRC.  `fnotify` will create this notifications in two cases:

* private messages
* highlighting (list of words)

To make that work, you'll have to install the `libnotify-bin` package.  Then,
you can modify the list of keywords (regular expressions) in the file
`~/.irssi/fnotify.keywords`.

In case you modify the script and want to reload it in a running `irssi`, you
can do the following command in `irssi`.

```
/script load fnotify.pl
```

Mutt configuration
==================

If you just cloned the repository, there is a few things to do before this
repository is fully functional.

Mail accounts configuration
===========================

First of all, you need to create GPG encrypted files for the mail accounts
loaded (see the beginning of the `muttrc` file).

There is a template that you can use to create these mail accounts' files (put
them in the `accounts` directory) in the file `accounts/muttrc.example`.

Then you can encrypt these files using the following command (`my_key` be the ID
of your GPG key).

```
gpg -e -rmy_key muttrc.account
```

Don't forget to start `mutt` with an active `gpg-agent`.  GNOME may do it for
you; however, last versions of `gpg` may give you the following warning message.

```
gpg: WARNING: The GNOME keyring manager hijacked the GnuPG agent.
gpg: WARNING: GnuPG will not work proberly - please configure that tool to not
interfere with the GnuPG system!
```

You may disable this hijacking by asking GNOME keyring to not interfere.  Use
the following command.

```
gnome-keyring-daemon  --components=ssh,secrets,pkcs11
```

Cache and temporary directories
===============================

If you never started `mutt` with this configuration, you'll need to create a few
directories for caches and a directory used for temporary files.

```
mkdir -p ~/.mutt/cache/headers
mkdir -p ~/.mutt/cache/messages
mkdir -p ~/.mutt/cache/temporary
```

References
==========

- [GNOME keyring hijacking GPG] and
    some help about [how to solve the problem]

[GNOME keyring hijacking GPG]: http://bugs.gnupg.org/gnupg/issue1656
[how to solve the problem]: http://forums.fedoraforum.org/showthread.php?s=16f52ade3a97b0337e7bebd7dcaa7a73&p=1706067

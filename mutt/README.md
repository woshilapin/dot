Mutt configuration
==================

If you just cloned the repository, there is a few things to do before this
repository is fully functional.

# Mail accounts configuration
First of all, you need to create GPG encrypted files for the mail accounts
loaded (see the beginning of the `muttrc` file).

This is a template that you can use to create these mail accounts' files (put
them in the `accounts` directory).

    set my_account_host="host.com"
    set my_account_login="mymail@$my_account_host"
    set my_account_pass="mypassword"
    
    set imap_authenticators="login"
    set imap_passive="no"
    set ssl_starttls="yes"
    set imap_user="$my_account_login"
    set imap_pass="$my_account_pass"
    set folder="imaps://$my_account_login@imap.$my_account_host:993/"
    set spoolfile="+INBOX"
    set postponed="+Drafts"
    set record="+Sent"
    
    set smtp_url="smtp://$my_account_login@smtp.$my_account_host:587/"
    set smtp_pass="$my_account_pass"
    set from="$my_account_login"
    set hostname="$my_account_host"
    
    unmailboxes *
    mailboxes "+INBOX" "+Sent" "+Drafts"

Then you can encrypt these files using the following command (`my_key` be the ID
of your GPG key).

    gpg -e -rmy_key muttrc.account

Don't forget to start `mutt` with an active `gpg-agent`.  GNOME may do it for
you; however, last versions of `gpg` may give you the following warning message.

    gpg: WARNING: The GNOME keyring manager hijacked the GnuPG agent.
    gpg: WARNING: GnuPG will not work proberly - please configure that tool to not
    interfere with the GnuPG system!

You may disable this hijacking by asking GNOME keyring to not interfere.  Use
the following command.

    gnome-keyring-daemon  --components=ssh,secrets,pkcs11

# Cache and temporary directories
If you never started `mutt` with this configuration, you'll need to create a few
directories for caches and a directory used for temporary files.

    mkdir -p ~/.mutt/cache/headers
    mkdir -p ~/.mutt/cache/messages
    mkdir -p ~/.mutt/cache/temporary

# References
* [GNOME keyring hijacking GPG](http://bugs.gnupg.org/gnupg/issue1656) and
  some help about [how to solve the
  problem](http://forums.fedoraforum.org/showthread.php?s=16f52ade3a97b0337e7bebd7dcaa7a73&p=1706067)

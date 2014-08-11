CardDAV with Mutt
=================

To complete addresses on `mutt`, we use `pycarddav`.  `pycarddav` is inserted as a submodule of the git repository `.dot`.


# Configuration of `pycarddav`
To use `pycarddav`, we need `keyring` to be installed.  We can install `keyring`
with `pip`.  However, it should be with Python version 2 since `pycarddav`
doesn't work with Python version 3.

    sudo apt-get install python2-pip
    sudo pip2 install keyring

Once `keyring` is installed, add the password for the CardDAV account.  See into
the file `~/.mutt/carddav/pycarddav.conf` for the name of the account and the
login (name of the account is the line that contains `[Account <name>]`): the
account name should be `perso` and the login should be `woshilapin`.

    keyring set pycarddav:perso woshilapin

Then finally, you can create or update the database with the following command
line.

    python2 ~/.mutt/carddav/pycarddav/bin/pycardsyncer -c ~/.mutt/carddav/pycarddav.conf

You can check that the database has been created by looking the
`~/.mutt/carddav/abook.db` file.

Since the account is accessed through SSL, the certificate is the file
`~/.mutt/carddav/tuziwo.info.pem`.

# Configuration of `mutt`
First of all, add the following line to your `muttrc` file to query through
`pycarddav` when emails are needed.

    set query_command="python2 ~/.mutt/carddav/pycarddav/bin/pc_query -c ~/.mutt/carddav/pycarddav.conf -m '%s'"

Then add the following line in order to use tabulation to complete addresses.

    bind editor <Tab> complete-query

# References
* [Use `pycarddav` with
  `mutt`](http://lostpackets.de/pycarddav/pages/usage.html)
* [Autocompletion in `mutt` using `pycarddav`
  database](https://kolab.org/blog/hugo-roy/2014/03/06/kolab%E2%80%99s-carddav-address-lookup-mutt)

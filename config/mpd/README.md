Installation
============

The setup of MPD is dependent of systemd.  You must have a systemd process for
the user.  You may check this is the case with the following command.

```
systemctl --user status
```

Thanks to the description of the mpd service in
`~/.config/systemd/user/mpd.service`, you may enable the MPD service for the
user.

```
systemctl --user enable mpd
```

The configured host (see `~/.config/mpd/mpd.conf`) is a socket
`~/.config/mpd/mpd.socket` which should be the value of the environment variable
`MPD_HOST`.  You may use `mpc` or `ncmpcpp` to communicate with this MPD daemon.

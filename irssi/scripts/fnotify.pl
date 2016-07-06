use strict;
use vars qw($VERSION %IRSSI);

use Irssi;

$VERSION = '0.0.3';
%IRSSI = (
	authors     => 'Jean SIMARD',
	contact     => 'woshilapin@gmail.com',
	name        => 'fnotify',
	description => 'Write a notification to a file and to the notification system that shows who is talking to you in which channel.',
	url         => 'http://hole.tuziwo.info/files/fnotify.pl',
	license     => 'GNU General Public License',
	changed     => '$Date: 2014-01-17 12:00:00 +0100$'
);

#--------------------------------------------------------------------
# Based on the fnotify.pl 0.0.3 by Thorsten Leemhuis
# http://www.leemhuis.info/files/fnotify/
# In parts based on knotify.pl 0.1.1 by Hugo Haas
# http://larve.net/people/hugo/2005/01/knotify.pl
# which is based on osd.pl 0.3.3 by Jeroen Coekaerts, Koenraad Heijlen
# http://www.irssi.org/scripts/scripts/osd.pl
#
# Other parts based on notify.pl from Luke Macken
# http://fedora.feedjack.org/user/918/
#
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# Utils
#--------------------------------------------------------------------

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+|\s+$//g;
	return $string;
}

#--------------------------------------------------------------------
# Private message parsing
#--------------------------------------------------------------------

sub privatemessage {
	my ($server, $text, $nick, $address, $target) = @_;
	my $title = "[private]";
	my $msg = "<" . $nick . "> " . $text;
	filewrite ($title . " " . $msg);
	notify ("IRC " . $title, $msg);
}

#--------------------------------------------------------------------
# Printing hilight's
#--------------------------------------------------------------------

my $prevnick = "";
sub publicmessage {
	my ($dest, $text, $stripped) = @_;
	my $text = trim($stripped);
	my $nick = "";
	if ($text =~ s/<(.*?)>\s*// ) { # Extract nickname
		$nick = trim($1); # Get back the nickname from last regexp
	} else {
		return;
	}
	open (KEYWORDSFILE, "<$ENV{HOME}/.irssi/fnotify.keywords") || die $!;
	foreach my $keyword (<KEYWORDSFILE>) {
		chomp $keyword;
		if ( (($dest->{level} & MSGLEVEL_PUBLIC) && ($text =~ qr/$keyword/i)) # Check if the keyword is in the text
			|| (($prevnick =~ qr/$keyword/i) && ($nick !~ qr/$keyword/i)) ) { # Check if the message is a response
			my $room = trim($dest->{target});
			my $title = "[" . $room . "]";
			my $msg = "<" . $nick . "> " . $text;
			filewrite ($title . " " . $msg);
			notify ("IRC " . $title, $msg);
			last;
		}
	}
	$prevnick = $nick;
	close (KEYWORDSFILE) || die $!;
}

#--------------------------------------------------------------------
# The actual printing
#--------------------------------------------------------------------

sub filewrite {
	my ($text) = @_;
	open (LOGFILE, ">>$ENV{HOME}/.irssi/fnotify.log");
	print LOGFILE $text . "\n";
	close (LOGFILE);
}
sub notify {
	my ($title, $msg) = @_;
	system "notify-send", "--app-name=irssi", "--icon=/usr/share/pixmaps/irssi.xpm", "--urgency=normal", "--expire-time=3000", $title, $msg;
}

#--------------------------------------------------------------------
# Irssi::signal_add_last / Irssi::command_bind
#--------------------------------------------------------------------

Irssi::signal_add_last ("message private", "privatemessage");
Irssi::signal_add_last ("print text", "publicmessage");

#- end

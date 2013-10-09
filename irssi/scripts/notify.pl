## https://raw.github.com/jhelwig/irssi-libnotify/master/notify.pl
## Put me in ~/.irssi/scripts, and then execute the following in irssi:
##
##       /load perl
##       /script load notify
##

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.01";
%IRSSI = (
    authors     => 'Luke Macken, Paul W. Frields',
    contact     => 'lewk@csh.rit.edu, stickster@gmail.com',
    name        => 'notify.pl',
    description => 'Use libnotify to alert user to hilighted messages',
    license     => 'GNU General Public License',
    url         => 'http://lewk.org/log/code/irssi-notify',
);

#Irssi::settings_add_str('notify', 'notify_icon', 'gtk-dialog-info');
Irssi::settings_add_str('notify', 'notify_time', '4000');

## sanitize 清洁 整理，对特殊标点进行转义
sub sanitize {
  my ($text) = @_;
  ## XXX KDE 下 notification 取消转义，否在 notification 不会对特殊字符进行转义
  #$text =~ s/&/&amp;/g;
  #$text =~ s/</&lt;/g;
  #$text =~ s/>/&gt;/g;
  #$text =~ s/'/&apos;/g;
  #$text =~ s/'/\'/g;
  return $text;
}

sub notify {
    my ($server, $summary, $message) = @_;

    # Make the message entity-safe
    $summary = sanitize($summary);
    $message = sanitize($message);

    ## XXX 去掉 icon 只显示文本消息即可
    #" -i " . Irssi::settings_get_str('notify_icon') .
    my $cmd = "EXEC - notify-send" .
    " -t " . Irssi::settings_get_str('notify_time') .
    " -- '" . $summary . "'" .
    " '" . $message . "'";

    $server->command($cmd);
}

sub print_text_notify {
    my ($dest, $text, $stripped) = @_;
    my $server = $dest->{server};

    return if (!$server || !($dest->{level} & MSGLEVEL_HILIGHT));
    my $sender = $stripped;
    $sender =~ s/^\<.([^\>]+)\>.+/\1/ ;
    $stripped =~ s/^\<.[^\>]+\>.// ;
    #my $summary = $dest->{target} . ": " . $sender;
    ## XXX 标题栏不显示消息内容，只显示 irc 消息房间
    my $summary = $dest->{target};
    notify($server, $summary, $stripped);
}

sub message_private_notify {
    my ($server, $msg, $nick, $address) = @_;

    my $username='@if_else';
    my $shortname='@if';
    my $vim_group='test@vim-cn.com/bot';
    my $twitter_bot='twitter.tweet.im';

    return if (!$server);

    ## XXX 对于 gtalk 群，不进行提示
    #if (($nick !~ /$vim_group/) && ($nick !~ /$twitter_bot/)) {
    if (($msg =~ /$username|$shortname/) || ($nick !~ /$vim_group|$twitter_bot/) ) {
        notify($server, "Private MSG : ".$nick, $msg);
    }
}

sub dcc_request_notify {
    my ($dcc, $sendaddr) = @_;
    my $server = $dcc->{server};

    return if (!$dcc);
    notify($server, "DCC ".$dcc->{type}." request", $dcc->{nick});
}

Irssi::signal_add('print text', 'print_text_notify');
Irssi::signal_add('message private', 'message_private_notify');
Irssi::signal_add('dcc request', 'dcc_request_notify');

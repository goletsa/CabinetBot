#!/usr/bin/perl
use strict;
use lib 'lib/';
use WWW::Telegram::BotAPI;
use Data::Dumper;
use ConfigTl;
use Command;
my $config = ConfigTl->new({});
my $token= $config->config()->{tokentl};
my $api = WWW::Telegram::BotAPI->new(
token => $token
);
my $command=Command->new;
$api->getUpdates();

while (1) {
if ( scalar @{ ( $api->getUpdates->{result} ) } == 0 ) { sleep 1; next; }
mesgtem();
next;
}

sub mesgtem(){
for ( my $i = 0 ; $i < scalar @{ ( $api->getUpdates->{result} ) } ; $i++ ) {
my @getmsg;
$getmsg[0]=$api->getUpdates->{result}[$i]{message}{text};
$getmsg[1]=$api->getUpdates->{result}[$i]{message}{from}{id};
$getmsg[2]=$api->getUpdates->{result}[$i]{message}{from}{username};
my $firstname=$api->getUpdates->{result}[$i]{message}{from}{first_name};
my $lastname=$api->getUpdates->{result}[$i]{message}{from}{last_name};
$getmsg[3]="$firstname $lastname";
$getmsg[0]=~s/\///;
$command->${\$getmsg[0]}($api,\@getmsg);
my $updateid = ( $api->getUpdates->{result}[$i]->{update_id} );
$api->getUpdates( { offset => $updateid + 1 } );
}
}

#!/usr/bin/perl
#Generate tokens
use lib 'lib/';
use DB;

my $base=DB->new();
my $db=$base->{tl_db};
$db->storage->debug(1);
$db->deploy;

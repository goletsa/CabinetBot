#!/usr/bin/perl
#Generate tokens
use lib 'lib/';
use DataQ;

DataQ->new()->getusers();

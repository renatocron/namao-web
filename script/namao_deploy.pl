#!/usr/bin/perl
$|++;

use strict;
use warnings;
use Data::Dumper;

use lib '../lib/', 'lib';
use NaMao::Schema;

my $schema = NaMao::Schema->connect('dbi:Pg:host=127.0.0.1;dbname=namao', 'postgres', '');

$schema->deploy();
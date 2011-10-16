use YAML::XS qw /LoadFile/;
use strict;

use Data::Dumper;
 use Config::General qw(ParseConfig SaveConfig SaveConfigString);

my $hash = LoadFile ('create.yml');

SaveConfig("create.conf", $hash);


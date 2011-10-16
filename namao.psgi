use strict;
use warnings;

use NaMao;

my $app = NaMao->apply_default_middlewares(NaMao->psgi_app);
$app;


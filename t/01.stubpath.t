use Test::More tests => 1;

BEGIN {
    $ENV{STUB_PATH} =  'stub';
}

use lib 't/lib';
use lib::stub;

is($INC[0],'stub');

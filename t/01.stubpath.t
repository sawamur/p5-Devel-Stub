use Test::More tests => 1;

BEGIN {
    $ENV{STUB} = 1;
}

use lib 't/lib';
use Stub::lib;

is($INC[0],'stub');

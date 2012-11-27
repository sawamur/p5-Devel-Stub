use Test::More tests => 3;

BEGIN {
    $ENV{STUB_PATH} = "t/stub";
}

use lib 't/lib';
use lib::stub;
use Foo::Bar;

is($INC[0],'t/stub');

my $b = Foo::Bar->new;

is($b->woo,"oh!");

is($b->moo,"moo!");

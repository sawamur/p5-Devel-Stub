BEGIN{
    $ENV{STUB} = 1;
    $ENV{STUB_TAG} = "devel";
}
use strict;
use Test::More;
use lib 't/lib';
use Devel::Stub::lib active_if => 1, path => "t/stub",quiet => 1;
use Foo::Bar;

my $b = Foo::Bar->new;

is $b->too,"tagged";
is $b->qoo,"qoo";

done_testing;



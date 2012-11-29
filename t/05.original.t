
use strict;
use Test::More;
use lib 't/lib';
use Stub::lib active_if => 1, path => "t/stub";
use Foo::Bar;


subtest 'original' => sub {
    my $b = Foo::Bar->new;
    is $b->poo(1),"stubed!";
    is $b->poo(0),"original!";
};

done_testing;

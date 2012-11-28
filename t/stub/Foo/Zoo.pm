package Foo::Zoo;
use Stub::Module on => "t/lib";

stub 'new' => sub {
    my $class = shift;
    bless { zoo => 1 },$class;
};


1;

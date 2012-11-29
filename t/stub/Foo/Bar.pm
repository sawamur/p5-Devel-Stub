package Foo::Bar;
use Stub::Module on => "t/lib";

stub woo => sub {
    "oh!";
};

stub poo => sub {
    my ($self,$p) = @_;
    unless($p){
        return _original_poo(@_);
    }
    "stubed!";
};




1;

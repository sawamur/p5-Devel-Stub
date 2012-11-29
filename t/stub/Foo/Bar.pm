package Foo::Bar;
use Stub::Module on => "t/lib";

stub woo => sub {
    "oh!";
};

stub poo => sub {
    my ($self,$p) = @_;
    if($p == 2){
        return _original(@_);
    } elsif( $p == 3){
        return $self->_original($p);        
    }
    
    "stubed!";
};




1;

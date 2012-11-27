package Stub::Module;
use strict;
use warnings;
use Module::Load;

sub stub {
    my ($name,$code) = @_;
    no strict 'refs';
    no warnings 'redefine';
    
    my ($pkg,$file,$line) = caller;
    *{"${pkg}::${name}"} = $code;
}


sub import{
    my $class = shift;
    my %params = @_ ;
    
    if ( $params{on}  ){
        my ($pkg,$file) = caller;
        no strict 'refs';
        *{"${pkg}::stub"} = \&stub;
        my $pkgpath = $pkg;
        $pkgpath =~ s/::/\//g;
        $pkgpath .= ".pm";
        $file =~ s/[\w\/]+(\/$pkgpath)$/$params{on}$1/;
        load $file;
    } 
}


1;

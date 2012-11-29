package Stub::Module;
use strict;
use warnings;
use Module::Load;
use Sub::Name qw/subname/;

sub stub {
    my ($name,$code) = @_;
    no strict 'refs';
    no warnings 'redefine';
    
    my ($pkg,$file,$line) = caller;
    my $original = \&{"${pkg}::${name}"};
    *{"${pkg}::__original_${name}"} = $original;
    *{"${pkg}::${name}"} = subname $name,$code;
}

sub import{
    my $class = shift;
    my %params = @_ ;
    
    if ( $params{on}  ){
        my ($pkg,$file) = caller;
        no strict 'refs';
        *{"${pkg}::stub"} = \&stub;
        *{"${pkg}::_original"} = sub {
          no strict 'refs' ;
          my (undef,undef,undef,$subr) = caller(1);
          my $name = ( split /::/,$subr )[-1];
          &{"${pkg}::__original_${name}"}(@_);
        };
        my $pkgpath = $pkg;
        $pkgpath =~ s/::/\//g;
        $pkgpath .= ".pm";
        $file =~ s/[\w\/]+(\/$pkgpath)$/$params{on}$1/;
        load $file;
    } 
}


1;

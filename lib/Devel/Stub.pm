package Devel::Stub;
use strict;
use warnings;
use Module::Load;
use Sub::Name qw/subname/;
use version; 
our $VERSION = qv('0.1.0');


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

__END__

=head1 NAME

Devel::Stub - stub some methods for development purpose

=head1 GOAL




=head1 SYNOPSIS


=head2 Devel::Stub::lib

Change lib path for stubbing.

 use lib qw/lib/;
 use Devel::Stub::lib;
 use Foo::Bar;

if $ENV{STUB} are given, this script load stub/Foo/Bar.pm 
instead of lib/Foo/Bar.pm.


=head2 Devel::Stub

Stub some methods on existing module.

  package Hoo::Bar;
  use Devel::Stub on => 'mylib';

  stub foo => sub {
      "stubbed!"
  };


=head1 EXAMPLE

Suppose these files;

  ./app.pl
  ./mylib/Abcd/Efg.pm
  ./mylib/Foo/Bar.pm
  ./stub/Foo/Bar.pm

=over

=item app.pl

 use lib 'mylib';
 use Devel::Stub::lib active_if => $ENV{STUB}
 use Foo::Bar;

 my $b = Foo::Bar->new
 print $b->woo;
 print $b->moo; 

=item mylib/Foo/Bar.pm

 package Foo::Bar

 sub new{
     bless {},shift;
 }
 sub woo{
     "woo!";
 }
 sub moo {
     "moo!"
 }

=item stub/Foo/Bar.pm

 package Foo::Bar;
 use Devel::Stub on => "mylib";

 stub woo => sub {
    "stubbed!";
 };

=back

normal use

 $ perl app.pl  #=> woo!moo!

stub use
 
 $ STUB=1 perl app.pl #=>stubbed!moo!



=head1 AUTHOR

Masaki Sawamura


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

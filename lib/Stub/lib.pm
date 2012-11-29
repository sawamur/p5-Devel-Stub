# -*- coding: utf-8 -*- 
package Stub::lib;

use warnings;
use strict;
use Carp;
use Module::Load;
use version; 
our $VERSION = qv('0.1.0');


sub import {
    my $class = shift;
    my %params = @_;
    my $active_if = $params{active_if} || $ENV{STUB};
    my $stubpath = $params{path} || "stub";
    my $quiet = $params{quiet};

    if ($active_if){
        unshift @INC,$stubpath if $INC[0] ne $stubpath;
        print STDERR __PACKAGE__," - path '$stubpath' have been added to \@INC\n" unless $quiet;
    }
}


1;
__END__

=head1 NAME

Stub::lib - change lib path for stubbing


=head1 SYNOPSIS

 use lib qw/lib/;
 use Stub::lib;
 use Foo::Bar;

if $ENV{STUB} are given, this script load stub/Foo/Bar.pm 
instead of lib/Foo/Bar.pm.


=head1 EXAMPLE

app.pl

 use lib 'mylib';
 use Stub::lib active_if => $ENV{STUB}
 use Foo::Bar;

 my $b = Foo::Bar->new
 print $b->woo;
 print $b->moo; 

mylib/Foo/Bar.pm

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

stub/Foo/Bar.pm

 package Foo::Bar;
 use Stub::Module on => "mylib";

 stub woo => sub {
    "stubbed!";
 };


normal use

 $ perl app.pl  #=> woo!moo!

stub use
 
 $ STUB=1 perl app.pl #=>stubbed!moo!



=head1 AUTHOR

Masaki Sawamura  C<< <sawamura.masaki@dena.jp> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura C<< <sawamura.masaki@dena.jp> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


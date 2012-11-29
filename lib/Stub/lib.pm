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

    if ($active_if){
        unshift @INC,$stubpath if $INC[0] ne $stubpath;
    }
}


1;
__END__

=head1 NAME

lib::stub - change lib path for stubbing


=head1 SYNOPSIS

 use lib qw/lib/;
 use lib::stub;
 use Foo::Bar;

if $ENV{STUB_PATH} are given, for example 'stub' , this script load
stub/Foo/Bar.pm instead of lib/Foo/Bar.pm.


=head1 EXAMPLE

app.pl

 use lib 'lib';
 use lib::stub;
 use Foo::Bar;

 my $b = Foo::Bar->new
 print $b->woo;
 print $b->moo; 

lib/Foo/Bar.pm

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
 use lib::stub on => "lib";

 stub woo => sub {
    "stubbed!";
 };


normal use

 $ perl app.pl  #=> woo!moo!

stub use
 
 $ STUB_PATH=stub perl app.pl #=>stubbed!moo!



=head1 AUTHOR

Masaki Sawamura  C<< <sawamura.masaki@dena.jp> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura C<< <sawamura.masaki@dena.jp> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


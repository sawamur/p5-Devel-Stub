# NAME

lib::stub - change lib path for stubbing



# SYNOPSIS

    use lib qw/lib/;
    use lib::stub;
    use Foo::Bar;

if $ENV{STUB\_PATH} are given, for example 'stub' , this script load
stub/Foo/Bar.pm instead of lib/Foo/Bar.pm.



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
    }



normal use

    $ perl app.pl  #=> woo!moo!

stub use
 

    $ STUB_PATH=stub perl app.pl #=>stubbed!moo!





# AUTHOR

Masaki Sawamura  `<sawamura.masaki@dena.jp>`



# LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura `<sawamura.masaki@dena.jp>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).

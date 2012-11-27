# NAME

lib::stub - スタブ用にライブラリパスを切り替えるもの



# SYNOPSIS


### 宣言

    use lib qw/lib/;
    use lib::stub;
    use Foo::Bar;

アプリ本体ファイルで上記のように宣言しておくと、環境変数STUB_PATHが設定されている場合において、
ライブラリパスにそれが追加される。つまり通常はFoo::Barは lib/Foo/Bar.pmを読み込むが
スタブパスが仮にstubと指定され、なおかつstub/Foo/Bar.pmが存在する場合はそちらが読み込まれる。
スタブモジュールではスタブ化したいメソッドのみを下記のように再定義する

### モジュール

    package Foo::Bar;
    use lib::stub on => "lib";  # <- lib/下にある同名モジュールを上書きするという宣言

    stub foobar => sub {
        #  元々のモジュールの sub foobar{ } を上書きする
    };

    # 他のメソッドは上書きされない
 
    1;

スタブ化したいモジュール同じパスになるように置く。(つまり lib/Foo/Bar.pmをスタブ化したい場合は stub/Foo/Bar.pmとする 
$ENV{STUB_PATH}がstubの場合 )。




# EXAMPLE

app.pl

    use lib 'lib';
    use lib::stub;  #stub化したいモジュールより先に宣言する
    use Foo::Bar;
    use Abcd::Efg;

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


通常の実行時

    $ perl app.pl  #=> woo!moo!


環境変数STUB_PATHをつけて実行した場合
 

    $ STUB_PATH=stub perl app.pl #=>stubbed!moo!


この例において、lib/Abcd/Efg.pm があり、stub/下には同モジュールがない場合は、通常通り
use Abcd::Efgで lib/Abcd/Efg.pmが読み込まれる。


# MERIT

本体のコードにほとんど手を入れずに切り替えられる。設定ファイルが減らせる。etc

# PROBLEM

モジュール名はこんなんでいいのだろうか？プラグマっぽいから小文字始まりにしてみたが。


# AUTHOR

Masaki Sawamura  `<sawamura.masaki@dena.jp>`



# LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura `<sawamura.masaki@dena.jp>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).

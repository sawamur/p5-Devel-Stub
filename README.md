# NAME

Stub::lib - スタブ用にライブラリパスを切り替えるもの

# GOAL 

やりたいこと

* ある一部のモジュールの一部のメソッドをスタブ化してアプリを立ち上げて動作確認したい。
* なるべく本体のコードに副作用がないようにしたい。


# SYNOPSIS


### 宣言 (メインのスクリプトにおいて)

    use lib qw/mylib/;
    use Stub::lib active_if => $ENV{STUB};
    use Foo::Bar;

アプリ本体ファイルで上記のように宣言しておくと、active_if引数で指定された値がtrueの場合、
ライブラリパスの先頭にスタブ用パス(デフォルト:stub)が追加される。
つまり通常はFoo::Barは mylib/Foo/Bar.pmを読み込むが
スタブパスが仮にstubと指定され、なおかつstub/Foo/Bar.pmが存在する場合はそちらが読み込まれる。
スタブモジュールではスタブ化したいメソッドのみを下記のように再定義する

### スタブ定義 (スタブパスに置かれたモジュールにおいて)

    package Foo::Bar;
    use Stub::Module on => "mylib";  # <- mylib/下にある同名モジュールを上書きするという宣言

    stub foobar => sub {
        #  元々のモジュールの sub foobar{ } を上書きする
    };

    # 他のメソッドは上書きされない
 
    1;

スタブ化したいモジュール同じパスになるように置く。(つまり lib/Foo/Bar.pmをスタブ化したい場合は stub/Foo/Bar.pmとする 
$ENV{STUB_PATH}がstubの場合 )。



# EXAMPLE


ファイル構成の例

```
.
├── app.pl
├── lib
│   ├── Abcd
│   │   └── Efg.pm
│   └── Foo
│       └── Bar.pm
└── stub
    └── Foo
        └── Bar.pm
```


app.pl

    use lib 'lib';
    use Stub::lib active_if => $ENV{STUB};  #stub化したいモジュールより先に宣言する
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
    use Stub::Module on => "lib";

    stub woo => sub {
       "stubbed!";
    };


通常の実行時

    $ perl app.pl  #=> woo!moo!


環境変数STUBをつけて実行した場合
 

    $ STUB=1 perl app.pl #=>stubbed!moo!


この例においては、lib/Abcd/Efg.pm があり、stub/下には同モジュールがないため、
use Abcd::Efgは通常どおり lib/Abcd/Efg.pmが読み込まれる。


# PARAMERTERS

### Stub::lib

use Stub::lib 

* active_if - 値が真の場合にスタブパスが追加される (省略可 デフォルト: $ENV{STUB})
* path - スタブパスを指定 (省略可 デフォルト: stub )

````
use Stub::lib active_if => ($ENV{APP_ENV} eq 'test'), path => 't/stub';
# 環境変数 APP_ENVが'test'であるとき t/stub をライブラリパスに追加
````

### Stub::Module

* on - 上書きするモジュールのサーチパス (必須)


```
package Your::Mod::Ule::Pack;
use Stub::Module on => "t/lib";
# t/lib/Your/Mod/Ule/Pack.pm をもとにスタブ化を行う
```



# NOTES

モジュール名の作法など要確認

# AUTHOR

Masaki Sawamura  `<sawamura.masaki@dena.jp>`



# LICENCE AND COPYRIGHT

Copyright (c) 2012, Masaki Sawamura `<sawamura.masaki@dena.jp>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).

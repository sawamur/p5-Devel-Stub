use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'lib::stub',
    AUTHOR              => 'Masaki Sawamura <sawamura.masaki@dena.jp>',
    VERSION_FROM        => 'lib/lib/stub.pm',
    ABSTRACT_FROM       => 'lib/lib/stub.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
        'Module::Load' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'lib-stub-*' },
);

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'lib::stub',
    license             => 'artistic2',
    dist_author         => 'Masaki Sawamura <sawamura.masaki@dena.jp>',
    dist_version_from   => 'lib/lib/stub.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'lib-stub-*' ],
);

$builder->create_build_script();

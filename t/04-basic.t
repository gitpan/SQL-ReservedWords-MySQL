#!perl

use strict;
use warnings;

use Test::More;

plan tests => 37;

use_ok( 'SQL::ReservedWords::MySQL' );

my @methods = qw[
    is_reserved
    is_reserved_by_mysql3
    is_reserved_by_mysql4
    is_reserved_by_mysql5
    words
];

can_ok( 'SQL::ReservedWords::MySQL', @methods );

foreach my $method ( @methods ) {
    ok ! __PACKAGE__->can($method), "$method was not exported by default";
}

ok   my @words = SQL::ReservedWords::MySQL->words,                     'Got words';
cmp_ok @words, '==', 234,                                              'Got 337 words';
ok   SQL::ReservedWords::MySQL->is_reserved('zerofill'),               'ZEROFILL is reserved';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql3('zerofill'),     'ZEROFILL is reserved by MySQL 3';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql4('zerofill'),     'ZEROFILL is reserved by MySQL 4';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql5('zerofill'),     'ZEROFILL is reserved by MySQL 5';
ok   SQL::ReservedWords::MySQL->is_reserved('accessible'),             'ACCESSIBLE is reserved';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql3('accessible'),   'ACCESSIBLE is not reserved MySQL 3';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql4('accessible'),   'ACCESSIBLE is not reserved MySQL 4';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql5('accessible'),   'ACCESSIBLE is reserved by MySQL 5';
ok   SQL::ReservedWords::MySQL->is_reserved('true'),                   'TRUE is reserved';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql3('true'),         'TRUE is not reserved by MySQL 3';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql4('true'),         'TRUE is reserved by MySQL 4';
ok   SQL::ReservedWords::MySQL->is_reserved_by_mysql5('true'),         'TRUE is reserved by MySQL 5';
ok ! SQL::ReservedWords::MySQL->is_reserved('bogus'),                  'BOGUS is not reserved';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql3('bogus'),        'BOGUS is not reserved by MySQL 3';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql4('bougus'),       'BOGUS is not reserved by MySQL 4';
ok ! SQL::ReservedWords::MySQL->is_reserved_by_mysql5('bogus'),        'BOGUS is not reserved by MySQL 5';
ok ! SQL::ReservedWords::MySQL->is_reserved(undef),                    'undef is not reserved';

use_ok 'SQL::ReservedWords::MySQL', @methods;

foreach my $method ( @methods ) {
    cmp_ok __PACKAGE__->can($method), '==', SQL::ReservedWords::MySQL->can($method), "$method was exported";
}

ok   @words = words(),                                                 'Got words';
ok   is_reserved('zerofill'),                                          'ZEROFILL is reserved';
ok   is_reserved_by_mysql3('zerofill'),                                'ZEROFILL is reserved by MySQL 3';
ok   is_reserved_by_mysql4('zerofill'),                                'ZEROFILL is reserved by MySQL 4';
ok   is_reserved_by_mysql5('zerofill'),                                'ZEROFILL is reserved by MySQL 5';

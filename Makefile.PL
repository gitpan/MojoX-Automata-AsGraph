use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'MojoX::Automata::AsGraph',
    AUTHOR        => 'Viacheslav Tikhanovskii <vti@cpan.org>',
    VERSION_FROM  => 'lib/MojoX/Automata/AsGraph.pm',
    ABSTRACT_FROM => 'lib/MojoX/Automata/AsGraph.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE' => 'perl')
        : ()),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'      => 0,
        'MojoX::Automata' => '0.500',
        'Graph::Easy'     => 0
    },
    dist  => {COMPRESS => 'gzip -9f', SUFFIX => 'gz'},
    clean => {FILES    => 'MojoX-Automata-AsGraph-*'}
);

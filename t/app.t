package Foo;

use base 'Mojo::Base';

package Bar;

use base 'Mojo::Base';

package main;

use strict;
use warnings;

use Test::More tests => 2;

use_ok('MojoX::Automata::AsGraph');

use MojoX::Automata;
use MojoX::Automata::AsGraph;

my $automata = MojoX::Automata->new;

$automata->state('f')->handler(Foo->new)->to(1 => 'e', 0 => 'b');
$automata->state('b')->handler(Bar->new)->to(1 => 'f', 0 => 'b');

my $graph = MojoX::Automata::AsGraph->graph($automata);

is($graph->as_ascii, <<'');
          0
  +--------------+
  v              |
+-------+  1   +---+  1   +---+
|   b   | ---> | f | ---> | e |
+-------+      +---+      +---+
  ^ 0 |
  +---+


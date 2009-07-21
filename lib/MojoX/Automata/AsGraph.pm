package MojoX::Automata::AsGraph;

use strict;
use warnings;

use Graph::Easy;

our $VERSION = '0.02';

sub _graph_easy { Graph::Easy->new }

sub graph {
    my $class = shift;
    my ($automata) = @_;

    return unless $automata;

    my $g = $class->_graph_easy;

    my $states = $automata->_states;

    my $nodes = {};

    foreach my $state (keys %$states) {
        my $transitions = $states->{$state}->_to;
        next unless $transitions;

        if (ref $transitions) {
            foreach my $t (keys %$transitions) {
                my $handler = $states->{$state}->handler;

                $handler = ref $handler if ref $handler;

                #my $node1 = ($nodes->{$state} ||= $graph->add_node();

                my ($first, $second, $edge) =
                  $g->add_edge($state, $transitions->{$t});

                $edge->set_attribute(label => $t);
            }
        }
        else {
            $g->add_edge($state, $states->{$state}->_to);
        }
    }

    return $g;
}

1;
__END__

=head1 NAME

MojoX::Automata::AsGraph - Create a graph from a MojoX::Automata object

=head1 SYNOPSIS

    my $automata = MojoX::Automata->new;

    $automata->state('f')->handler(Foo->new)->to(1 => 'e', 0 => 'b');
    $automata->state('b')->handler(Bar->new)->to(1 => 'f', 0 => 'b');

    my $graph = MojoX::Automata::AsGraph->graph($automata);

    print $graph->as_ascii;

=head1 DESCRIPTION

This is a similar to L<MojoX::Routes::AsGraph> graph builder for
L<MojoX::Automata>.

=head1 METHODS

=head2 C<graph>

    my $graph = MojoX::Automata::AsGraph->graph($automata);

Creates L<Graph::Easy> instance.

=head1 AUTHOR

Viacheslav Tikhanovskii, C<vti@cpan.org>.

=head1 COPYRIGHT

Copyright (C) 2009, Viacheslav Tikhanovskii.

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl 5.10.

=cut

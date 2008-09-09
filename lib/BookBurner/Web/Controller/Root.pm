package BookBurner::Web::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

BookBurner::Web::Controller::Root - Root Controller for BookBurner::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub _dt {
  scalar localtime $_[0];
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    my $reading = $c->model('BBDB::Reading')->search->next;
    my $book    = $reading->book;

    my $body = sprintf "You are currently reading %s by %s.<br />",
      $book->title, $book->author;

    $body .= sprintf "It has %s pages.  You began on %s.<br /><br />",
      $book->pages, _dt($reading->started_at);

    my @updates = $reading->search_related(updates => {}, {
      order_by => 'updated_at'
    })->all;

    for my $update (@updates) {
      $body .= sprintf "By %s, you had read up to page %s.<br />",
        _dt($update->updated_at), $update->new_position;
    }

    $c->response->body($body);
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
    
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Ricardo Signes

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

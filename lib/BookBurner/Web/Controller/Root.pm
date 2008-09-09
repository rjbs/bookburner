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

    my @plot = [ 0, $book->pages ];

    for my $update (@updates) {
      $body .= sprintf "By %s, you had read up to page %s.<br />",
        _dt($update->updated_at), $update->new_position;

      push @plot, [
        ($update->updated_at - $reading->started_at) / 3_600,
        $book->pages - $update->new_position
      ];
    }

    my $img = 'http://chart.apis.google.com/chart?cht=lxy&chs=400x200&chm=c,000000,0,0,10|c,000000,0,1,10|c,000000,0,2,10|c,000000,0,3,10&chxt=x,y&chd=t:'
            . join(',', map { $_->[0] } @plot)
            . '|'
            . join(',', map { $_->[1] } @plot)
            . '&chds=0,' . $book->pages;

    $body .= "<img src='$img' style='float:left' />";

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

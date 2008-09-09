package BookBurner::Web::Model::BBDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'BookBurner::Schema',
    
);

=head1 NAME

BookBurner::Web::Model::BBDB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<BookBurner::Web>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<BookBurner::Schema>

=head1 AUTHOR

Ricardo Signes

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

use strict;
use warnings;
package BookBurner::Schema;
use parent 'DBIx::Class::Schema';

__PACKAGE__->load_classes(qw/Book Reading ReadingUpdate/);

1;

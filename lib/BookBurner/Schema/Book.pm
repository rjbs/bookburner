use strict;
use warnings;
package BookBurner::Schema::Book;
use parent 'DBIx::Class';
__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('books');

__PACKAGE__->add_columns(
  id => {
    data_type   => 'int',
    is_nullable => 0,
  },

  catalog_id => {
    data_type   => 'int',
    is_nullable => 0,
  },

  catalog_item_id => {
    data_type   => 'int',
    is_nullable => 0,
  },

  title => {
    data_type   => 'varchar',
    is_nullable => 0,
  },

  author => {
    data_type   => 'varchar',
    is_nullable => 0,
  },

  pages => {
    data_type   => 'int',
    is_nullable => 0,
  }
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->add_relationship('readings', 'Reading', {
  'foreign.book_id' => 'self.id',
});


1;

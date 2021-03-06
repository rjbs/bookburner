use strict;
use warnings;
package BookBurner::Schema::Reading;
use parent 'DBIx::Class';
__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('readings');

__PACKAGE__->add_columns(
  id => {
    data_type   => 'int',
    is_nullable => 0,
  },

  book_id => {
    data_type   => 'int',
    is_nullable => 0,
    is_foreign_key => 1,
  },

  started_at => {
    data_type   => 'datetime',
    is_nullable => 0,
  },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_one(book => 'BookBurner::Schema::Book');
__PACKAGE__->has_many(updates => 'BookBurner::Schema::ReadingUpdate',
  { 'foreign.reading_id' => 'self.id' },
);

1;

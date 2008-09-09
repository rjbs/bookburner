use strict;
use warnings;
package BookBurner::Schema::ReadingUpdate;
use parent 'DBIx::Class';
__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('reading_updates');

__PACKAGE__->add_columns(
  id => {
    data_type   => 'int',
    is_nullable => 0,
  },

  reading_id => {
    data_type   => 'int',
    is_nullable => 0,
    is_foreign_key => 1,
  },

  updated_at => {
    data_type   => 'datetime',
    is_nullable => 0,
  },

  new_position => {
    data_type   => 'int',
    is_nullable => 0,
  },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->add_relationship('reading', 'Reading', {
  'foreign.id' => 'self.reading_id',
});

1;

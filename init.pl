use strict;
use warnings;
use lib 'lib';

use BookBurner::Schema;

my $schema = BookBurner::Schema->connect('dbi:SQLite:bb.sqlite', undef, undef);
$schema->deploy;

my $book = $schema->resultset('Book')->create({
  catalog_id      => 1,
  catalog_item_id => 1,

  title  => 'The Crack in Space',
  author => 'Philip K. Dick',
  pages  => 200,
});

my $reading = $book->related_resultset('readings')->create({
  started_at => time,
});

my $page = 0;
my $date = time;

for (1,2,3) {
  $page += int rand 50;
  $date += int rand (5 * 86_400);
  $reading->related_resultset('updates')->create({
    updated_at   => $date,
    new_position => $page,
  });
}

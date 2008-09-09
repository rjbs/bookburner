use strict;
use warnings;
use LWP::UserAgent;
use XML::Simple;

my $host = 'www.librarything.com';
my $api_version = '1.0';
my $key = '57ab032fe393f9beaae19b74d500175b';

my $uri = sprintf 'http://%s/services/rest/%s/?method=%s&id=%s&apikey=%s',
  $host, $api_version, 'librarything.ck.getwork', 48053, $key;

my $res = LWP::UserAgent->new->get($uri);

my $xml = $res->content;

my $ref = XMLin($xml);

use Data::Dumper;
print Dumper($ref);

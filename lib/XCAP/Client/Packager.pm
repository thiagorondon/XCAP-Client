
package XCAP::Client::Packager;

use Moose;

has ['destination', 'doc_name', 'doc'] => (is => 'rw', isa => 'Str');
has 'status' => (is => 'ro', isa => 'Int');

1;


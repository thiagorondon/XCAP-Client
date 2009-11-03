
package XCAP::Client::Document;

use Moose;

has app => (is => 'rw', isa => 'Str', default => 'pres-rules');
has xmlns => (is => 'rw', isa => 'Str', default => 'urn:ietf:params:xml:ns:pres-rules');
has mime_type => (is => 'rw', isa => 'Str', default => 'application/auth-policy+xml');

#defaul is Client->username
has scope => (is => 'rw', isa => 'Str');

has document_name => (is => 'rw', isa => 'Str', default => 'index');


1;



package XCAP::Client::Connection;

use Moose;

use LWP::UserAgent;
use URI::Split qw(uri_split);

has ['uri', 'auth_realm', 'auth_username','auth_password', 'content'] => (
    is => 'rw', 
    isa => 'Str'
);

has 'useragent' => ( 
    is => 'rw', 
    isa => 'Object',
    lazy => 1,
    default => sub { LWP::UserAgent->new }
);

has 'netloc' => (
    is => 'ro',
    isa => 'Str', 
    lazy => 1, 
    default => sub { 
        my $self = shift;
        my ($scheme, $auth) = uri_split($self->uri);
        $auth;
    }
);

sub _request () {
    my ($self, $method) = @_;

    $self->useragent->credentials($self->netloc, $self->auth_realm,
                   $self->auth_username, $self->auth_password);
    
    $self->useragent->request
        (HTTP::Request->new($method => $self->uri))->content;
}

sub get { $_[0]->_request('GET'); }   

sub delete { $_[0]->_request('DELETE'); }

1;


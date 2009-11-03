
package XCAP::Client::Connection;

use Moose;

use LWP::UserAgent;
use URI::Split qw(uri_split);

has ['uri', 'auth_realm', 'auth_username','auth_password', 'content'] => 
    (is => 'rw', isa => 'Str');

sub get {
    my $self = shift;
    
    my $ua = LWP::UserAgent->new;
    my ($scheme, $auth) = uri_split($self->uri);
    $ua->credentials(
    $auth, $self->auth_realm, $self->auth_username, $self->auth_password);
    my $response = $ua->request(HTTP::Request->new(GET => $self->uri));
    
    $response->content;
}   

1;


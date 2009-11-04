#!/usr/bin/perl

package XCAP::Client;

use Moose;
use Moose::Util::TypeConstraints;

use XCAP::Client::Connection;

has ['xcap_root', 'user'] => (
    is => 'rw',
    isa => 'Str'
);

has ['auth_realm', 'auth_username', 'auth_password'] => ( 
    is => 'rw', 
    isa => 'Str'
);

has 'uri' => (
    is => 'rw', 
    isa => 'Str', 
    lazy => 1, 
    default => sub { 
        my $self = shift;
        join ('/', $self->xcap_root, $self->application, $self->tree, 
            $self->user, $self->filename);
    },
);

has 'application' => (
    is => 'rw', 
    isa => enum([qw[resource-lists rls-services pres-rules pdif-manipulation watchers xcap-caps ]]), 
    default => 'pres-rules'
);

has 'tree' => (
    is => 'ro', 
    isa => enum([qw[users global]]),
    default => 'users'
);

has 'filename' => (
    is => 'rw', 
    isa => 'Str', 
    default => 'index'
);

has 'connection' => (
    is => 'ro', 
    isa => 'Object',
    lazy => 1,
    default => sub {
        my $self = shift;
        XCAP::Client::Connection->new(
            uri => $self->uri,
            auth_realm => $self->auth_realm,
            auth_username => $self->auth_username,
            auth_password => $self->auth_password
        )
    }
);

# METHODS

sub delete () { $_[0]->connection->delete; }

sub fetch () { $_[0]->connection->fetch; }

sub put () { $_[0]->connection->put; }

sub replace () { $_[0]->connection->replace; }

=head1 NAME

XCAP::Client - XCAP client protocol (RFC 4825).

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    use XCAP::Client;

	my $xcap_client = new XCAP::Client(
		xcap_root => "https://my.xcapserver.org/xcap-root",
		user => "sip:foo@domain.org",
		auth_username => "foo",
		auth_password => "bar",
		ssl_verify_cert => 1,
	);

	$xcap_client->put(%xcap_doc); 

	$xcap_client->fetch("pres-rules");

=head1 DESCRIPTION

XCAP (RFC 4825) is a protocol on top of HTTP which allows a client to manipulate the contents of Presence Information Data Format (PIDF) based presence documents. These documents are stored in a server in XML format and are fetched, modified, replaced or deleted by the client. The protocol allows multiple clients to manipulate the data, provided that they are authorized to do so. XCAP is already used in SIMPLE-based presence systems for manipulation of presence lists and presence authorization policies.

XCAPClient library implements the XCAP protocol in client side, allowing the applications to get, store, modify and delete XML documents in the server. 

The module implements the following features:

 * Fetch, create/replace and delete a document.
 * Parameters allowing customized fields for each XCAP application.
 * Manage of multiple documents per XCAP application.
 * SSL support.

Todo:

 * Fetch, create/replace and delete a document element (XML node)
 * Fetch, create/replace and delete an element attribute. 
 * Exception for each HTTP error response.
 * Fetch the XCAP server auids, extensions and namespaces.

=head1 ATTRIBUTES

=head2 xcap_root

xcap_root - 

=head2 user 

user -

=head2 auth_username

auth_realm -


=head2 auth_username

auth_username -

=head2 auth_password

auth_password - 


=head2 ssl_verify_cert

ssl_verify_cert - 


=head1 AUTHOR

Thiago Rondon <thiago@aware.com.br>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Aware.

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=cut

1;


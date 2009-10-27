#!/usr/bin/perl

package XCAP::Client;

use Moose;

#use XCAP::Client::Client;
#use XCAP::Client::Application;
#use XCAP::Client::Document;
#use XCAP::Client::Errors;

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

	$xcap_client->get("pres-rules");

=head1 DESCRIPTION

XCAP (RFC 4825) is a protocol on top of HTTP which allows a client to manipulate the contents of Presence Information Data Format (PIDF) based presence documents. These documents are stored in a server in XML format and are fetched, modified, replaced or deleted by the client. The protocol allows multiple clients to manipulate the data, provided that they are authorized to do so. XCAP is already used in SIMPLE-based presence systems for manipulation of presence lists and presence authorization policies.

XCAPClient library implements the XCAP protocol in client side, allowing the applications to get, store, modify and delete XML documents in the server. 

=head1 ATTRIBUTES

=head2 xcap_root

xcap_root - 

=cut

has 'xcap_root' => ( is => 'rw', isa => 'Str');

=head2 user 

user -

=cut

has 'user' => ( is => 'rw', isa => 'Str');

=head2 auth_username

auth_username -

=cut

has 'auth_username' => ( is => 'rw', isa => 'Str');

=head2 auth_password

auth_password - 

=cut

has 'auth_password' => ( is => 'rw', isa => 'Str');

=head2 ssl_verify_cert

ssl_verify_cert - 

=cut

has 'ssl_verify_cert' => ( is => 'rw', isa => 'Bool');


=head1 AUTHOR

Thiago Rondon <thiago@aware.com.br>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Aware.

This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=cut


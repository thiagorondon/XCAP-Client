#!/usr/bin/perl 

use strict;
use warnings;

use Test::More qw(no_plan);

use XCAP::Client;

BEGIN {
	use_ok ('XCAP::Client');
}

our $xcap_root = 'http://localhost/xcap-root';
our $user = 'sip:username@example.org';
our $auth_username = 'auth_username';
our $auth_password = 'auth_password';

our $connect_info = {
    xcap_root => $xcap_root,
    user => $user,
    auth_username => $auth_username,
    auth_password => $auth_password,
};

ok(ref (my $conn = XCAP::Client->new($connect_info)) eq 'XCAP::Client');

1;


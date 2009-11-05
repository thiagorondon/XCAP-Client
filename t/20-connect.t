#!/usr/bin/perl 

use strict;
use warnings;

use Test::More qw(no_plan);
use Test::Exception;

use XCAP::Client;

BEGIN {
	use_ok ('XCAP::Client');
}

our $pres_rules_file = '';
our $xcap_root = 'http://localhost/xcap-root';
our $user = 'sip:username@example.org';
our $auth_username = 'auth_username';
our $auth_password = 'auth_password';

my $xcap_client = XCAP::Client->new;

ok(ref $xcap_client eq 'XCAP::Client');

dies_ok { $xcap_client->xcap_root('foobar') } 'Wrong xcap_root URI';
dies_ok { $xcap_client->user('foobar') } 'Wrong user identification';

lives_ok { $xcap_client->xcap_root($xcap_root) } 'XCAP_root URI';
lives_ok { $xcap_client->user($user) } 'User identification';
lives_ok { $xcap_client->auth_username($auth_username) } 'Auth username';
lives_ok { $xcap_client->auth_password($auth_password) } 'Auth password';



1;


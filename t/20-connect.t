#!/usr/bin/perl 

use strict;
use warnings;
use FindBin qw($Bin);

use Test::More qw(no_plan);
use Test::Exception;

use XCAP::Client;

BEGIN {
	use_ok ('XCAP::Client');
}

our $example_file = "$Bin/PRES_RULES_EXAMPLE.xml";
our $xcap_root = 'http://localhost:8000/xcap-root';
our $user = 'sip:username@example.org';
our $auth_realm = 'sip.nocphone.com';
our $auth_username = 'auth_username';
our $auth_password = 'auth_password';

open FILE, '<', $example_file or die "Unable to open $example_file: $!";
our @content = <FILE>;
close (FILE);

our $xcap_client = XCAP::Client->new;

ok(ref $xcap_client eq 'XCAP::Client');

# Test Types.
dies_ok { $xcap_client->xcap_root('foobar') } 'Wrong xcap_root URI';
dies_ok { $xcap_client->user('foobar') } 'Wrong user identification';

# ...
lives_ok { $xcap_client->xcap_root($xcap_root) } 'XCAP_root URI';
lives_ok { $xcap_client->user($user) } 'User identification';
lives_ok { $xcap_client->auth_realm($auth_realm) } 'Auth realm';
lives_ok { $xcap_client->auth_username($auth_username) } 'Auth username';
lives_ok { $xcap_client->auth_password($auth_password) } 'Auth password';

# The real host.
lives_ok { $xcap_client->xcap_root($xcap_root) } 'XCAP_root URI';
is ($xcap_client->xcap_root, $xcap_root, 'attr xcap_root');
is ($xcap_client->user, $user, 'attr user');
is ($xcap_client->auth_realm, $auth_realm, 'auth realm');
is ($xcap_client->auth_username, $auth_username, 'auth username');
is ($xcap_client->auth_password, $auth_password, 'auth password');

# Replace, delete, create and fetch a document.
lives_ok { $xcap_client->document->content(join('',@content)) } 'XML Content';
ok (grep {/20[01]/} $xcap_client->document->create, 'create method');
is ($xcap_client->document->delete, 200, 'delete method');
ok (grep {/20[01]/} $xcap_client->document->replace, 'delete method');
is ($xcap_client->document->fetch, join('', @content), 'fetch method');


# Wrong host
#lives_ok { $xcap_client->xcap_root('http://xsa.sidjqaks.co') } 'XCAP_root';
#dies_ok { $xcap_client->document->f

1;





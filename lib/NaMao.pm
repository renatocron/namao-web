package NaMao;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

	Authentication
	Static::Simple

	Session
	Session::Store::Cache
	Session::State::Cookie
	Session::PerUser

	Cache

/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in namao.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'NaMao',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->config->{'Plugin::Cache'}{backend} = { 
 	class => 'Cache::FileCache',
	default_expires_in => 24 * 60 * 40 * 60,
	cache_root => 'cache/filecache'
};

__PACKAGE__->config(
	"Plugin::Session" => {
		expires => 24 * 60 * 40 * 60,
		#storage => 'cache/sessions',
		#cache_size => '100m'
	},
);

# Configure SimpleDB Authentication
__PACKAGE__->config(
	'Plugin::Authentication' => {
		default => {
			class           => 'SimpleDB',
			user_model      => 'DB::User',
			password_type   => 'self_check',
		},
	},
);
__PACKAGE__->config({
	'Controller::HTML::FormFu' => {
		constructor => {
			render_method => 'tt',
			tt_args => {
				ENCODING => 'UTF-8',
			},
			languages => ['pt-br']
		},
	},
	'View::TT' => {
		ENCODING => 'UTF-8',
	},
});

=pod
__PACKAGE__->config(
	"Plugin::Authentication" => {
		default_realm => "twitter",
		realms => {
			twitter => {
				credential => {
					class => "Twitter",
				},

				consumer_key    => '7M3kGlNsZOQYwPZl4EjxA',
				consumer_secret => 'bwBh2iUYVIg2bJ9vHJFkF2PcD3sYOGAc3ihF1HGeQ',
				callback_url => 'http://perfectword.renatocron.com/twitter/callback',
				# you can bypass the above by including
				# "twitter_consumer_key", "twitter_consumer_secret",
				# and "twitter_callback_url" in your Catalyst site
				# configuration or yml file
			},
		},
	}
);
=cut

# Start the application
__PACKAGE__->setup();


=head1 NAME

NaMao - Catalyst based application

=head1 SYNOPSIS

    script/namao_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<NaMao::Controller::Root>, L<Catalyst>

=head1 AUTHOR

renatosouza,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

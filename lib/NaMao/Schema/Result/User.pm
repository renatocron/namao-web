package NaMao::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 NAME

NaMao::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 email_address

  data_type: 'text'
  is_nullable: 1

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 active

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "username",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "email_address",
  { data_type => "text", is_nullable => 1 },
  "first_name",
  { data_type => "text", is_nullable => 1 },
  "last_name",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "active",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 user_logins

Type: has_many

Related object: L<NaMao::Schema::Result::UserLogin>

=cut

__PACKAGE__->has_many(
  "user_logins",
  "NaMao::Schema::Result::UserLogin",
  { "foreign.id_user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<NaMao::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "NaMao::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-15 14:54:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:46c+7144gavs6yOqQvgTIQ

__PACKAGE__->add_columns(
	'password' => {
		passphrase       => 'rfc2307',
		passphrase_class => 'SaltedDigest',
		passphrase_args  => {
			algorithm   => 'SHA-1',
			salt_random => 22.
		},
		passphrase_check_method => 'check_password',
	},
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

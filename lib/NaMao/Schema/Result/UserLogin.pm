package NaMao::Schema::Result::UserLogin;

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

NaMao::Schema::Result::UserLogin

=cut

__PACKAGE__->table("user_login");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_login_id_seq'

=head2 id_user

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 login_date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 ip_address

  data_type: 'text'
  is_nullable: 1

=head2 useragent

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "user_login_id_seq",
  },
  "id_user",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "login_date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "ip_address",
  { data_type => "text", is_nullable => 1 },
  "useragent",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id_user

Type: belongs_to

Related object: L<NaMao::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "id_user",
  "NaMao::Schema::Result::User",
  { id => "id_user" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-12 18:01:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8jy0a1S/vHfAZ9u/mp+O3g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

use utf8;
package Teleg::Schema::Result::Token;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Teleg::Schema::Result::Token

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tokens>

=cut

__PACKAGE__->table("tokens");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 uid

  data_type: 'integer'
  is_nullable: 0

=head2 login

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 token

  data_type: 'char'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "uid",
  { data_type => "integer", is_nullable => 0 },
  "login",
  { data_type => "char", is_nullable => 0, size => 20 },
  "token",
  { data_type => "char", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uid>

=over 4

=item * L</uid>

=item * L</login>

=item * L</token>

=back

=cut

__PACKAGE__->add_unique_constraint("uid", ["uid", "login", "token"]);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2016-12-23 09:59:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LhimIHXR5MG+ljVSATguew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

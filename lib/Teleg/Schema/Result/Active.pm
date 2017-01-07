use utf8;
package Teleg::Schema::Result::Active;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Teleg::Schema::Result::Active

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<active>

=cut

__PACKAGE__->table("active");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 uid

  data_type: 'integer'
  is_nullable: 1

=head2 tl_id

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 tl_nick

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 tl_name

  data_type: 'char'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "uid",
  { data_type => "integer", is_nullable => 1 },
  "tl_id",
  { data_type => "char", is_nullable => 0, size => 20 },
  "tl_nick",
  { data_type => "char", is_nullable => 1, size => 30 },
  "tl_name",
  { data_type => "char", is_nullable => 1, size => 128 },
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

=item * L</tl_id>

=back

=cut

__PACKAGE__->add_unique_constraint("uid", ["uid", "tl_id"]);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2016-12-23 09:59:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yyipcOH4WmuArZJofHLe/Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

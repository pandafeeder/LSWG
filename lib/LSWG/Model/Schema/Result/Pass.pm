package LSWG::Model::Schema::Result::Pass;
use base qw/DBIx::Class::Core/;
use utf8;

__PACKAGE__->table('pass');

__PACKAGE__->add_columns(
    username => {
	data_type => 'text',
    },
    password => {
	data_type => 'text',
    },
);


__PACKAGE__->set_primary_key('password');


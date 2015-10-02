package LSWG::Model::Schema::Result::Save;
use base qw/DBIx::Class::Core/;
use utf8;

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);
__PACKAGE__->table('Save');

__PACKAGE__->add_columns(
    
    id => {
	data_type => 'integer',
	is_auto_increment => 1,
    },
    author => {
	data_type => 'text',
    },
    title => {
	data_type => 'text',
    },
    content => {
	data_type => 'text',
    },
    date_saved => {
	data_type => 'datetime',
    },
);


__PACKAGE__->set_primary_key('id');


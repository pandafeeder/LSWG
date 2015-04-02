package LSWG::Model::Schema::Result::Post;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);
__PACKAGE__->table('posts');

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
    date_published => {
	data_type => 'datetime',
    },
);


__PACKAGE__->set_primary_key('id');


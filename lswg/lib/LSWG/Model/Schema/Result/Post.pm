package LSWG::Model::Schema::Result::Post;
use base 'DBIx::Class::Core';

__PACKAGE__->table('posts');

__PACKAGE__->add_columns(
    
    id => {
	data_type => 'intger',
	is_auto_increment => 1,
    },
    author => {
	data_type => 'text',
    },
    title => {
	date_type => 'text',
    },
    content => {
	date_type => 'text',
    },
    date_published => {
	data_type => 'datetime',
    }
);


__PACKAGE__->set_primary_key('id');

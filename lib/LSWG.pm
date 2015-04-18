package LSWG;
use Mojo::Base 'Mojolicious';
use LSWG::Model::Schema;
use DateTime;
use utf8;
use Mojolicious::Plugin::Bcrypt;

# This method will run once at server start
sub startup {
  my $self = shift;
#use bcrypt to encrypt password
  $self->plugin('bcrypt');
 
#connect to post and pass database
  my $schema = LSWG::Model::Schema->connect('dbi:SQLite:database/post.db','', '', {sqlite_unicode => 1});
  my $pass_db = LSWG::Model::Schema->connect('dbi:SQLite:database/pass.db');

#check existence of post and pass db, deploy if not existed 
  if (-e 'database/post.db') {
	  print "post database exist\n";
  } else {
  	  $schema->deploy();
  }

  if (-e 'database/pass.db') {
	  print "pass database exist\n";
  } else {
  	  $pass_db->deploy();
#create default username and password
	  $pass_db->resultset('Pass')->create({
		username => 'admin',
		password => '000000',
	  });
  }

#create helper db for post.db, passdb for pass.db
  $self->helper(db => sub {return $schema});
  $self->helper(passdb => sub {return $pass_db});

  $self->secrets(['Mojolicious rock']);
  $self->app->sessions->cookie_name('LSWG');
  $self->app->sessions->default_expiration('600');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('index#welcome');
  $r->get('/admin')->to('admin#admin');
  $r->post('/admin')->to('admin#login');
  $r->get('/posts(:id)',[id=>qr/\d+/])->to('posts#single_page');

  my $logged_in = $r->under('/')->to('admin#is_logged_in');
  $logged_in->get('/restrict')->to('admin#restrict');

  my $add_post = $r->under('/')->to('admin#is_logged_in');
  $add_post->get('add_post')->to('admin#add_post');
  $add_post->post('add_post')->to('admin#create');

  my $delete_post = $r->under('/')->to('admin#is_logged_in');
  $delete_post->get('/delete(:id)', [id=>qr/\d+/])->to('admin#delete_post');

  my $edit_post = $r->under('/')->to('admin#is_logged_in');
  $edit_post->get('/edit(:id)', [id=>qr/\d+/])->to('edit#edit_page');
  $edit_post->post('/edit(:id)', [id=>qr/\d+/])->to('edit#edit_post');

  my $changepass = $r->under('/')->to('admin#is_logged_in');
  $changepass->get('changepass')->to('admin#changepage');
  $changepass->post('changepass')->to('admin#changepass');
  $r->get('/logout')->to('admin#logout');
}

1;


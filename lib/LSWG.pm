package LSWG;
use Mojo::Base 'Mojolicious';
use LSWG::Model::Schema;
use DateTime;
use utf8;
#use Mojolicious::Plugin::Bcrypt;

# This method will run once at server start
sub startup {
  my $self = shift;
#use bcrypt to encrypt password
#$self->plugin('bcrypt');
 
#connect to post and pass database
  my $schema = LSWG::Model::Schema->connect('dbi:SQLite:database/post.db','', '', {sqlite_unicode => 1});
  my $pass_db = LSWG::Model::Schema->connect('dbi:SQLite:database/pass.db');
  my $save_db = LSWG::Model::Schema->connect('dbi:SQLite:database/save.db','', '', {sqlite_unicode => 1});

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
  
   if (-e 'database/save.db') {
	   print "save database exist\n";
   } else {
	   $save_db->deploy();
   }

#create helper db for post.db, passdb for pass.db
  $self->helper(db => sub {return $schema});
  $self->helper(passdb => sub {return $pass_db});
  $self->helper(savedb => sub {return $save_db});

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
  $add_post->post('add_post')->to('admin#create_or_save');

  my $delete_post = $r->under('/')->to('admin#is_logged_in');
  $delete_post->get('/postdelete(:id)', [id=>qr/\d+/])->to('admin#delete_post');

  my $edit_post = $r->under('/')->to('admin#is_logged_in');
  $edit_post->get('/postedit(:id)', [id=>qr/\d+/])->to('edit#edit_page');
  $edit_post->post('/postedit(:id)', [id=>qr/\d+/])->to('edit#edit_post');

  my $save_post = $r->under('/')->to('admin#is_logged_in');
  $save_post->get('/save(:id)', [id=>qr/\d+/])->to('posts#single_save');
  $save_post->get('/saveedit(:id)', [id=>qr/\d+/])->to('edit#edit_page');
  $save_post->post('/saveedit(:id)', [id=>qr/\d+/])->to('edit#edit_post');
  $save_post->get('/savedelete(:id)', [id=>qr/\d+/])->to('admin#delete_post');

  my $changepass = $r->under('/')->to('admin#is_logged_in');
  $changepass->get('changepass')->to('admin#changepage');
  $changepass->post('changepass')->to('admin#changepass');
  $r->get('/logout')->to('admin#logout');

  $r->any('/*whatever' => {whatever => ''} => sub {
  my $c = shift;
  my $whatever = $c->param('whatever');
  $c->render(text => "the page you request not found", status => 404);
  });
}

1;


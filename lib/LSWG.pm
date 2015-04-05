package LSWG;
use Mojo::Base 'Mojolicious';
use LSWG::Model::Schema;
use DateTime;

# This method will run once at server start
sub startup {
  my $self = shift;

  my $schema = LSWG::Model::Schema->connect('dbi:SQLite:database/my.db');
  
  if (-e 'database/my.db') {
	  print "database exist\n";
  } else {
  	  $schema->deploy();
  }

  $self->helper(db => sub {return $schema});

  $self->secrets(['Mojolicious rock']);

  #$self->plugin('PODRenderer');

  $self->app->sessions->cookie_name('LSWG');
  $self->app->sessions->default_expiration('600');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('index#welcome');
  $r->get('/admin')->to('admin#admin');
  $r->post('/admin')->to('admin#login');

  my $logged_in = $r->under('/')->to('admin#is_logged_in');
  #$logged_in->get('/restrict');
  $logged_in->get('/restrict')->to('admin#restrict');
  my $add_post = $r->under('/')->to('admin#is_logged_in');
  $add_post->get('add_post')->to('admin#add_post');
  $add_post->post('add_post')->to('admin#create');

  $r->get('/logout')->to('admin#logout');
}

1;


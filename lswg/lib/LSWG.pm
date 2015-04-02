package LSWG;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

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
  $r->get('/logout')->to('admin#logout');
}

1;


package LSWG::Controller::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use utf8;

my %USER = (
    user => 'qusr',
    pass => '1111'
);

sub admin{
  my $self = shift;
}

sub login{
  my $self = shift;
  my $user = $self->param("UserName");
  my $pass = $self->param("PassWord");
  if ($user eq $USER{user} && $pass eq $USER{pass}) {
	$self->session(logged_in => 1);
	$self->session(username => $user);
	$self->redirect_to('restrict');
  } else {
	$self->render(text => "Wrong");
  }
}

sub is_logged_in {
  my $self = shift;
  return 1 if $self->session('logged_in');
  $self->render(text => "Please login first"); 
  return undef;
}

sub restrict {
  my $self = shift;
}

sub add_post {
  my $self = shift;
}

sub delete_post {
  my $self = shift;
  my $posts = $self->db->resultset('Post');
  $posts->search({ id => $self->stash('id')})->delete;
  $self->redirect_to('restrict');
}

sub create {
  my $self = shift;
  my $title = $self->param('title');
  my $content = $self->param('content');
  $self->db->resultset('Post')->create({
		title => $title,
		content => $content,
		author => 'UserName',
		date_published => DateTime->now,
  });
  $self->flash(post_saved => 1);
  $self->redirect_to('restrict');
}

sub logout {
  my $self = shift;
  $self->session(expires => 1);
  $self->redirect_to('/');
}

1;

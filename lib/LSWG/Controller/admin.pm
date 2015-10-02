package LSWG::Controller::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
#use LSWG::Model::Authorized;
use utf8;

sub admin{
  my $self = shift;
}

sub login{
  my $self = shift;
  my $user = $self->param("UserName");
  my $pass = $self->param("PassWord");
  my @table = $self->passdb->resultset('Pass')->all;
  my $userInDb = $table[0]->username;
  my $passInDb = $table[0]->password;
  if ($user eq $userInDb && $pass eq $passInDb) {
	$self->session(logged_in => 1);
	$self->session(username => $user);
	$self->redirect_to('restrict');
  } else {
	$self->flash(authorize => "Wrong Name or password");
	$self->redirect_to('admin');
  }
}

sub is_logged_in {
  my $self = shift;
  return 1 if $self->session('logged_in');
  $self->flash(login_need => "Please login first"); 
  $self->redirect_to('admin');
  return undef;
}

sub restrict {
  my $self = shift;
}

sub add_post {
  my $self = shift;
}

sub changepage {
  my $self = shift;
}

sub changepass {
  my $self = shift;
  my $passwd = $self->param('newPassWord');
  my @table  = $self->passdb->resultset('Pass')->all;
  $table[0]->password($passwd);
  $table[0]->update;
  $self->redirect_to('restrict');
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

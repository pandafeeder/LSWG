package LSWG::Controller::Admin;
use Mojo::Base 'Mojolicious::Controller';

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

sub logout {
  my $self = shift;
  $self->session(expires => 1);
  $self->redirect_to('/');
}

1;

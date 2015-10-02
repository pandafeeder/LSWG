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

sub save_page {
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
  my $url = $self->url_for;
  my $posts;
  if ($url =~ /postdelete/) {
    $posts = $self->db->resultset('Post');
  } elsif ($url =~ /savedelete/) {
    $posts = $self->savedb->resultset('Save');
  } else {
    $self->render(text => "wrong path");
  }
  $posts->search({ id => $self->stash('id')})->delete;
  $self->redirect_to('restrict');
}


sub create_or_save {
  my $self = shift;
  my $title = $self->param('title');
  my $content = $self->param('content');
  my $button = $self->param('p_button') || $self->param('s_button');
  if ($button eq "Publish") {
	$self->db->resultset('Post')->create({
	    title => $title,
	    content => $content,
	    author => 'UserName',
	    date_published => DateTime->now,
	});
    } elsif ($button eq "Save") {
	$self->savedb->resultset('Save')->create({
	    title => $title,
	    content => $content,
	    author => 'UserName',
	    date_saved => DateTime->now,
	});
    }    
  $self->redirect_to('restrict');
}

sub logout {
  my $self = shift;
  $self->session(expires => 1);
  $self->redirect_to('/');
}

1;

package LSWG::Controller::Edit;
use DateTime;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

sub edit_page {
  my $self = shift;
  my $url = $self->url_for;
  my $posts;
  if ($url =~ /post/) {
    $posts = $self->db->resultset('Post');
  } elsif ($url =~ /save/) {
    $posts = $self->savedb->resultset('Save');
  } else {
    $self->render(text => "wrong path");
  }
  my $single = $posts->search({ id => $self->stash('id')})->single;
  my $pass = [($single->title, $single->content)];
  $self->render( pass => $pass);
}

sub edit_post {
  my $self = shift;
  my $url = $self->url_for;
  my $button = $self->param('p_button')|$self->param('s_button');
  if ($button eq 'Publish' && $url =~ /post/ ) {
    my $posts = $self->db->resultset('Post');
    $self->update($posts);
    $self->redirect_to('restrict');
    return;
  }
  if ($button eq 'Save' && $url =~ /save/) {
    my $saves = $self->savedb->resultset('Save');
    $self->update($saves);
    $self->redirect_to('restrict');
    return;
  } 
  if ($button eq 'Publish' && $url =~ /save/) {
    my $posts = $self->db->resultset('Post');
    $self->create($posts, 'post');
    $self->redirect_to('restrict');
    return;
  }
  if ($button eq 'Save' && $url =~ /post/) {
    my $saves = $self->savedb->resultset('Save');
    $self->create($saves, 'save');
    $self->redirect_to('restrict');
    return;
  }
}

sub update {
    my ($self, $db) = @_;
    my $single = $db->search({ id => $self->stash('id')})->single;
    my $title = $self->param('title');
    my $content = $self->param('content');
    $single->title($title);
    $single->content($content);
    $single->update;
}

sub create {
    my ($self, $db, $flag) = @_;
    if ($flag eq 'post') {
	$db->create({
	    title => $self->param('title'),
	    content => $self->param('content'),
	    author => 'Username',
	    date_published => DateTime->now,
        });
        return;
    }
    if ($flag eq 'save') {
	$db->create({
	    title => $self->param('title'),
	    content => $self->param('content'),
	    author => 'Username',
	    date_saved => DateTime->now,
        });
        return;
    }
}

1;

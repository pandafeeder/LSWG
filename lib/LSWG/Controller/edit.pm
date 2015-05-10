package LSWG::Controller::Edit;
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
  my $posts;
  if ($url =~ /post/) {
    $posts = $self->db->resultset('Post');
  }elsif($url =~ /save/) {
    $posts = $self->savedb->resultset('Save');
  } else {
    $self->render(text => "wrong path");
  }
  my $single = $posts->search({ id => $self->stash('id')})->single;
  my $title = $self->param('title');
  my $content = $self->param('content');
  $single->title($title);
  $single->content($content);
  $single->update;
  $self->redirect_to('restrict');
}

1;

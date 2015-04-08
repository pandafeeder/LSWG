package LSWG::Controller::Edit;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

sub edit_page {
  my $self = shift;
  my $posts = $self->db->resultset('Post');
  my $single = $posts->search({ id => $self->stash('id')})->single;
  my $pass = [($single->title, $single->content)];
  $self->render( pass => $pass);
}

sub edit_post {
  my $self = shift;
  my $title = $self->param('title');
  my $content = $self->param('content');
}

1;

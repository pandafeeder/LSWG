package LSWG::Controller::Posts;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

sub single_page {
  my $self = shift;
  
  my $posts = $self->db->resultset('Post');
  my $single = $posts->search({ id => $self->stash('id')})->single;
  my $pass = [($single->title, $single->content, $single->date_published->set_time_zone('local')->strftime('%Y-%m-%d %H:%M:%S'))];
  $self->stash( pass => $pass );
}

1;

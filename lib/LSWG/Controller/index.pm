package LSWG::Controller::Index;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;
#  my $posts = $self->db->resultset('Post');
#  my @all = $posts->all;

  $self->render(msg1 => "hello");
}

1;

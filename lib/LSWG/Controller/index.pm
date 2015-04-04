package LSWG::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

#  my $posts = $self->db->resultset('Post');
#  my @pp = $posts->all;

#  $self->stash(title => '$pp[0]->title');
  # Render template "example/welcome.html.ep" with message
  #$self->render( title => $title[0], content => $content[0]);
  #$self->render( ppp => [qw(post1 post2 post3)]);
}

1;

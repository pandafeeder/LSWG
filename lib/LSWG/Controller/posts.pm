package LSWG::Controller::Posts;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

sub single_page {
  my $self = shift;
  
  my $posts = $self->db->resultset('Post');
  my $single = $posts->search({ id => $self->stash('id')})->single;
  my $pass = [($single->title, $single->content)];
  $self->render( pass => $pass);
  #$self->stash({title => $single->title, content => $single->content} );

#  my @pp = $posts->all;
#  $self->stash(title => '$pp[0]->title');
  # Render template "example/welcome.html.ep" with message
  #$self->render( title => $title[0], content => $content[0]);
  #$self->render( ppp => [qw(post1 post2 post3)]);
}

1;

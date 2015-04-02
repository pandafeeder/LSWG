package LSWG::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;
  my @title = qw(post1 post2 post3);
  my @content = qw(content1 content2 content3);
  # Render template "example/welcome.html.ep" with message
  #$self->render( title => $title[0], content => $content[0]);
  #$self->render( ppp => [qw(post1 post2 post3)]);
}

1;

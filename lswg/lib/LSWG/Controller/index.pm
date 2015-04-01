package LSWG::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(title => 'post1', content => "This is content of post1");
}

1;

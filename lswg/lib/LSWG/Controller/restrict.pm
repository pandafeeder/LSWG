package LSWG::Controller::Restrict;
use Mojo::Base 'Mojolicious::Controller';

sub hello {
    my $self = shift;
    $self->render(text => "Hello");
}

1;

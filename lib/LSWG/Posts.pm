package LSWG::Posts;
use utf8;
use Mojo::Base 'Mojolicious::Controller';

sub single_page {
  my $self = shift;
  my $url = $self->url_for;
  if ( $url =~ /post/) {
    my $posts = $self->db->resultset('Post');
    my $single = $posts->search({ id => $self->stash('id')})->single;
    my $pass = [($single->title, $single->content, $single->date_published->set_time_zone('Asia/Shanghai')->strftime('%Y-%m-%d %H:%M:%S'))];
    $self->stash( pass => $pass );
    return ;
  } elsif ( $url =~ /save/) {
    my $posts = $self->savedb->resultset('Save');
    my $single = $posts->search({ id => $self->stash('id')})->single;
    my $pass = [($single->title, $single->content, $single->date_saved->set_time_zone('Asia/Shanghai')->strftime('%Y-%m-%d %H:%M:%S'))];
    $self->stash( pass => $pass );
    return ;
  } else {
    $self->render( text => "wrong path");
    return ;
  } 
}

1;

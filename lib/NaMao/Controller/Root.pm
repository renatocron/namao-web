package NaMao::Controller::Root;
use Moose;
use namespace::autoclean;


BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

NaMao::Controller::Root - Root Controller for NaMao

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
	      $c->stash->{message} = 'Hello World!';
#	$c->forward('View::HTML');

    #$c->response->body( 'hello world!' );
}

=head2 default

Standard 404 error page

=cut
 
sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
	my( $self, $c ) = @_;
	return if $c->res->body || $c->res->redirect;
	$c->forward( $c->view('Web') );
}

=head1 AUTHOR

renatosouza,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

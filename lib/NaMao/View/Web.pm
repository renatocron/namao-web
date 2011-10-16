package NaMao::View::Web;

use strict;
use warnings;

use base 'Catalyst::View::TT';

use Template::AutoFilter;

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,

	INCLUDE_PATH => [
		NaMao->path_to( 'root', 'src' ),
		NaMao->path_to( 'root', 'lib' ),
	],

	WRAPPER            => 'wrapper.tt2',

	CLASS => 'Template::AutoFilter',
	

);
 
=head1 NAME

NaMao::View::Web - TT View for NaMao

=head1 DESCRIPTION

TT View for NaMao.

=head1 SEE ALSO

L<NaMao>

=head1 AUTHOR

renatosouza,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

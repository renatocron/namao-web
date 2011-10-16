package NaMao::Controller::Login;
use Moose;
use namespace::autoclean;


BEGIN {extends 'Catalyst::Controller'; }
BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }
=head1 NAME

NaMao::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	# Get the username and password from form
	my $username = $c->request->params->{u};
	my $password = $c->request->params->{p};

	# If the username and password values were found in form
	if ($username && $password) {
		# Attempt to log the user in
		if ($c->authenticate({ username => $username,
								password => $password  } )) {
	
			$c->model('DB::UserLogin')->create({
				id_user => $c->user->id(),
				ip_address => $c->req->address,
				useragent => $c->req->user_agent
		
	});

			# If successful, then let them use the application
			$c->response->redirect($c->uri_for($c->controller('Root')->action_for('index')));
			return;
		} else {
			# Set an error message
			$c->stash(msg => "Tu errou a senha ou ta tentando dar uma de troll no meu site!");
		}
	} elsif ($c->req->method eq 'POST') {
		# Set an error message
		$c->stash(msg => "PRECISA ESCREVER O USUÁRIO NEH!")
			unless ($c->user_exists);
	}

    $c->stash({
		pmsg => 'PUTA MERDA!',	
		alert => 'error'
	});
}

=pod
sub create :Path :Args(0) {
    my ( $self, $c ) = @_;

	# Get the username and password from form
	my $username   = $c->request->params->{user};
	my $firstname  = $c->request->params->{firstname};
	my $lastname   = $c->request->params->{lastname};
	my $password   = $c->request->params->{pass};
	my $email      = $c->request->params->{email};

	# If the username and password values were found in form
	if ($username && $password) {
		# Attempt to log the user in
		if ($c->authenticate({ username => $username,
								password => $password  } )) {
	
			$c->model('DB::UserLogin')->create({
				id_user => $c->user->id(),
				ip_address => $c->req->address,
				useragent => $c->req->user_agent
			});

			# If successful, then let them use the application
			$c->response->redirect($c->uri_for($c->controller('Root')->action_for('index')));
			return;
		} else {
			# Set an error message
			$c->stash(msg => "Tu errou a senha ou ta tentando dar uma de troll no meu site!");
		}
	} elsif ($c->req->method eq 'POST') {
		# Set an error message
		$c->stash(msg => "PRECISA ESCREVER O USUÁRIO NEH!")
			unless ($c->user_exists);
	}

    $c->stash({
		pmsg => 'PUTA MERDA!',	
		alert => 'error'
	});
}
=cut
    
sub create :Local :Args(0) :FormConfig {
	my ($self, $c) = @_;

	# Get the form that the :FormConfig attribute saved in the stash
	my $form = $c->stash->{form};

	# Check if the form has been submitted (vs. displaying the initial
	# form) and if the data passed validation.  "submitted_and_valid"
	# is shorthand for "$form->submitted && !$form->has_errors"
	if ($form->submitted) {
	
		if (!$form->has_errors) {
			# Create a new book
			my $user = $c->model('DB::User')->new_result({});
			# Save the form data for the book
			$form->model->update($user);
			# Set a status message for the user & return to books list
			#$c->response->redirect($c->uri_for($self->action_for('list'),
			#	{mid => $c->set_status_msg("Book created")}));
			#$c->detach;
		}
	} else {
		# Get the authors from the DB
		#my @author_objs = $c->model("DB::Author")->all();
		# Create an array of arrayrefs where each arrayref is an author
		#my @authors;
		#foreach (sort {$a->last_name cmp $b->last_name} @author_objs) {
		#	push(@authors, [$_->id, $_->last_name]);
		#}
		# Get the select added by the config file
		#my $select = $form->get_element({type => 'Select'});
		# Add the authors to it
		#$select->options(\@authors);
	}

	# Set the template
	#$c->stash(template => 'books/formfu_create.tt2');
}
 

sub logout :Path('/logout') :Args(0) {
	my ($self, $c) = @_;

	# Clear the user's state
	$c->logout;

	# Send the user to the starting point
	$c->response->redirect($c->uri_for('/'));
	return 0;
}

=head1 AUTHOR

renatosouza,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

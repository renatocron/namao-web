#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'NaMao';
all_from 'lib/NaMao.pm';

requires 'Catalyst::Runtime' => '5.90004';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';

requires 'HTML::FormFu';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'HTML::FormFu::Model::DBIC';

requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::Cache';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::PerUser';

requires 'Catalyst::Plugin::Cache';
requires 'MooseX::NonMoose';

requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;

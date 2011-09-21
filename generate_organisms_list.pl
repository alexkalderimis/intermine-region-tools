#!/usr/bin/perl

use strict;
use warnings;

use Webservice::InterMine 0.9800;

my $base = $ARGV[0] or die "No base url provided";
my $name = $ARGV[1] or die "No name provided";

my $query = new_query(from => [$base], class => "Organism");

$query->select("shortName", "name");

open(my $fh, '>', $name .'_organisms.tsv') or die "$!";

while (<$query>) {
    print $fh $_->{shortName}, "\t", $_->{name}, "\n";
}

close $fh or die "$!";

exit;

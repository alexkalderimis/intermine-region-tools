#!/usr/bin/perl

use strict;
use warnings;

use Webservice::InterMine 0.9800;

my $base = $ARGV[0] or die "No base url provided";
my $name = $ARGV[1] or die "No name provided";

my $model = get_service($base)->model;

open(my $fh, '>', $name .'_classes.tsv') or die "$!";

for my $cd (sort {$a->name cmp $b->name} $model->get_all_classdescriptors) {
    print $fh $cd->unqualified_name, "\t", $cd->unqualified_name, "s\n";
}

close $fh or die "$!";

exit;

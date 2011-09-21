#!/usr/bin/perl

use strict;
use warnings;

use Webservice::InterMine 0.9800;

my $base = $ARGV[0] or die "No base url provided";
my $name = $ARGV[1] or die "No name provided";

my $model = get_service($base)->model;

my %seq_feq_types;

for my $cd ($model->get_all_classdescriptors) {
    $seq_feq_types{$cd}++ if $cd->sub_class_of("SequenceFeature");
}

open(my $fh, '>', $name . '_sf_types.tsv') or die "$!";

for my $type (sort keys %seq_feq_types) {
    print $fh "${type}\t${type}s\n";
}

close $fh or die "$!";

exit;

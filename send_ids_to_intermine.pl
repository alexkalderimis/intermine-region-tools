#!/usr/bin/perl

use strict;
use warnings;

use Webservice::InterMine 0.9800;

my ($ids, $type, $name, $description, $tags, $token, $out_f, $base) = @ARGV;

my $list = get_service($base, $token)->new_list(
 type => $type, content => $ids, description => $description, name => $name, tags => [split(/,/, $tags)]
);

open(my $fh, '>', $out_f) or die "$!";
printf $fh "%s\t%s\t%d\n", $list->name, $list->type, $list->size;
close $fh or die "$!";

exit;

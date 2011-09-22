#!/usr/bin/perl

use strict;
use warnings;

use Webservice::InterMine 0.9800;

my ($symbols, $name, $description, $tags, $token, $out_f, $base) = @ARGV;

open( my $in_fh, '<', $symbols) or die "$!";
my @symbols = <$in_fh>;
chomp(@symbols);
close($in_fh) or die "$!";

my $service = get_service($base, $token);

my $query = $service->new_query(class => "Gene");
$query->add_constraint(symbol => [@symbols]);
my $list = $service->new_list(
    content => $query, description => $description, name => $name, tags => [split(/,/, $tags)]
);

open(my $fh, '>', $out_f) or die "$!";
printf $fh "%s\t%s\t%d\n", $list->name, $list->type, $list->size;
close $fh or die "$!";

exit;

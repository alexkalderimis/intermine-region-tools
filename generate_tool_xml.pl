#!/usr/bin/perl
#
use strict;
use warnings;

my %mapping = (
    "send_list_template" => "send_list_",
    "send_gene_symbols_template" => "send_list_of_gene_symbols_",
    "send_ids_template" => "send_list_of_ids",
);

my ($base, $name) = @ARGV;

while (my($k, $v) = each %mapping) {
    open(my $in, '<', $k . '.xml') or die "$!";
    open(my $out, '>', $v . $name . '.xml') or die "$!";

    while(<$in>) {
        s/{{name}}/$name/g;
        s/{{base}}/$base/g;
        print $out $_;
    }

    close $in or warn "$!";
    close $out or warn "$!";
}

exit;

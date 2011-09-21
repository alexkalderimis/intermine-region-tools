#!/usr/bin/perl
#
use strict;
use warnings;

my ($base, $name) = @ARGV;

open(my $in, '<', 'send_list_template.xml') or die "$!";
open(my $out, '>', 'send_list_' . $name . '.xml') or die "$!";

while(<$in>) {
    s/{{name}}/$name/g;
    s/{{base}}/$base/g;
    print $out $_;
}

close $in or warn "$!";
close $out or warn "$!";

exit;

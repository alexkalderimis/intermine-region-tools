#!/usr/bin/perl
#
use strict;
use warnings;

my ($base, $name) = @ARGV;

open(my $in, '<', 'fetch_features_template.xml') or die "$!";
my %outs;
for my $format (qw/gff3 fasta bed/) {
    open(my $out, '>', 'fetch_features_' . $name . '_' . $format . '.xml') or die "$!";
    $outs{$format} = $out;
}

while(<$in>) {
    s/{{name}}/$name/g;
    s/{{base}}/$base/g;
    for my $format (keys %outs) {
        my $x = $_;
        $x =~ s/{{format}}/$format/g;
        my $fh = $outs{$format};
        print $fh $x;
    }
}

close $in or warn "$!";
for my $out (values %outs) {
    close $out or warn "$!";
}

exit;

#!/usr/bin/perl

use strict;
use warnings;

use LWP;
use JSON;

my $ua = LWP::UserAgent->new();

my ($in_f, $organism, $extension, $featureTypes, $out_f, $base, $format) = @ARGV;

my $url = $base . '/service/regions/' . $format;

open (my $ifh, '<', $in_f) or die "$!";
my @regions = <$ifh>;
chomp @regions;
close $ifh or die "$!";

my $search_info = {
        organism => $organism,
        featureTypes => [split(/,/, $featureTypes)],
        extension => $extension,
        regions => \@regions,
};

my $response = $ua->post($url, {query => encode_json($search_info)});

if ($response->is_success) {
    open (my $outfh, '>', $out_f) or die "$!";
    print $outfh $response->content;
    close $outfh or die "$!";
} else {
    die $response->content;
}

exit;



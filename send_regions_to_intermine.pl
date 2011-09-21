#!/usr/bin/perl

use strict;
use warnings;

use LWP;
use JSON;

my $ua = LWP::UserAgent->new();

my ($in_f, $organism, $extension, $featureTypes, $list_name, $list_description, $token, $out_f, $base) = @ARGV;

my $url = $base . '/service/regions/list';

open(my $ifh, '<', $in_f) or die "$!";

my @regions = <$ifh>;
chomp @regions;
close $ifh or die "$!";

my $search_info = {
        organism => $organism,
        featureTypes => [split(/,/, $featureTypes)],
        extension => $extension,
        regions => \@regions,
};

my $response = $ua->post($url, {
        name => $list_name,
        description => $list_description,
        query => encode_json($search_info),
        token => $token,
    });

if ($response->is_success) {
    open (my $outfh, '>', $out_f) or die "$!";
    my $data = decode_json($response->content);
    printf $outfh "%s\t%s\t%d\n", $data->{listName}, $data->{type}, $data->{listSize};
    close $outfh or die "$!";
} else {
    my $data = decode_json($response->content);
    die $data->{error}, "\n";
}

exit;

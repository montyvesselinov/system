#!/usr/bin/env perl
use strict;
use warnings;
use Lingua::EN::Sentence qw(get_sentences);

sub normalize
{
    my($str) = @_;
    $str =~ s/\n/ /gm;
    $str =~ s/\s\s+/ /gm;
    return $str;
}

{
    local $/ = "\n\n";
    while (<>)
    {
        chomp;
        print "Para: [[$_]]\n";
        my @sentences = split m/(?<=[.!?])\s+/m, $_;
        foreach my $sentence (@sentences)
        {
            $sentence = normalize $sentence;
            print "Ad Hoc Sentence: $sentence\n";
        }
        my $sref = get_sentences($_);
        foreach my $sentence (@$sref)
        {
            $sentence = normalize $sentence;
            print "Lingua Sentence: $sentence\n";
        }
    }
}

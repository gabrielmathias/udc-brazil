#!/usr/bin/perl
use strict;
use warnings;

while (<>) {
    my @parts = split ( /</ , $_);
    print($parts[0] , "\n");
    print($parts[1] , "\n");
    print($parts[2] , "\n");
}
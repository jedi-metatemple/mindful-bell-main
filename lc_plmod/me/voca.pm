package me::voca;
use strict;
use alarmica;

my $chimera;
my $initra = 0;

sub initio {
  if ( $initra > 5 ) { return; }
  $chimera = &alarmica::shlc_svol("0","0.02","0.08","0.14");
  $initra = 10;
}

sub roar {
  if ( $initra < 5 ) { &initio(); }
  system($chimera);
}



1;

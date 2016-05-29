package me::voca;
use strict;
use alarmica;
use argola;

my $chimera;
my $initra = 0;

sub initio {
  if ( $initra > 5 ) { return; }
  #$chimera = &alarmica::shlc_svol("0","0.02","0.08","0.14");
  $chimera = &alarmica::shlc_svol("0","0.02","0.08","0.25");
  $initra = 10;
}

sub roar {
  if ( $initra < 5 ) { &initio(); }
  system($chimera);
}

sub custsnd {
  my $lc_rvl;
  my $lc_loc;
  my $lc_vol;
  my $lc_cmtot;
  my $lc_cmneo;
  if ( $initra < 5 ) { &initio(); }
  $lc_rvl = 'a';
  $lc_cmtot = '';
  while ( $lc_rvl ne 'x' )
  {
    $lc_loc = &argola::getrg();
    $lc_vol = &argola::getrg();
    
    $lc_cmneo = 'chobakwrap-sound -vol ' . &wraprg::bsc($lc_vol);
    $lc_cmneo .= ' -snd ' . &wraprg::bsc($lc_loc) . ' &bg';
    $lc_cmneo = '( ( ' . $lc_cmneo . ' ) || true )';
    
    $lc_rvl = &argola::getrg();
    if ( ! (&argola::yet()) ) { $lc_rvl = 'x'; }
    $lc_cmtot .= $lc_cmneo;
    if ( $lc_rvl ne 'x' )
    {
      $lc_cmtot .= ' && sleep ' . &wraprg::bsc($lc_rvl) . ' && ';
    }
  }
  
  $lc_cmtot = '( ' . $lc_cmtot . ' ) &bg';
  $lc_cmtot = '( ' . $lc_cmtot . ' ) > /dev/null 2> /dev/null';
  
  $chimera = $lc_cmtot;
}



1;

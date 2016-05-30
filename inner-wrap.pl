use argola;
use chobaktime;
use me::atnow;
use me::voca;
use strict;

# Minimum Interval of Chime Sequences
my $btween_min_sec = 40; # Selected Value
my $btween_mns_min = 10; # Minimal Value

# Target-Average Interval of Chime Sequences
my $btween_avg_sec = 300;
# -- minimum value is double $btween_min_sec

# Pre-Initial Convergence Rounds Remaining
my $preinit_rounds_rm = 0;
# This variable is important so that the earlier
# chimes won't be too predictable.

# Bufferic Factor;
my $buf_factor = 4;


# Mode option(s) to chobakwrap-caff:
my @chobak_caff_opt = ( '-full' );

# Storage for Variables in Action:
my $accessa;


sub opto__avg_do {
  my $lc_a;
  $lc_a = &argola::getrg();
  $btween_avg_sec = int(($lc_a * 60) + &argola::getrg() + 0.2);
} &argola::setopt('-avg',\&opto__avg_do);

sub opto__wake_do {
  &me::atnow::stayawake();
} &argola::setopt('-wake',\&opto__wake_do);

&argola::setopt('-snd',\&me::voca::custsnd);



&argola::runopts();

$accessa = {
  'min' => $btween_min_sec,
  'avg' => $btween_avg_sec,
  'buf' => $buf_factor,
};
&me::atnow::init($accessa);

while ( $preinit_rounds_rm > 0.5 )
{
  system("echo","Normalizing: " . $preinit_rounds_rm);
  
  &me::atnow::advan($accessa);
  &me::atnow::rwind($accessa);
  $preinit_rounds_rm = int($preinit_rounds_rm - 0.8);
}

while ( 2 > 1 )
{
  my $lc_a;
  $lc_a = `date`; chomp($lc_a);
  #system("echo","Normalizing: " . $preinit_rounds_rm);
  &me::atnow::advan($accessa);
  
  if ( $accessa->{'nex'} > &chobaktime::nowo() )
  {
    system("echo",("MINDFULNESS: " . $lc_a));
    &me::voca::roar();
    &me::atnow::waittime($accessa);
  }
}





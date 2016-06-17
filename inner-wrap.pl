use argola;
use chobaktime;
use me::atnow;
use me::voca;
use strict;

# Minimum Interval of Chime Sequences
my $btween_min_sec = 40;

# Target-Average Interval of Chime Sequences
my $btween_avg_sec = 300;

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

sub opto__min_do {
  my $lc_a;
  $lc_a = &argola::getrg();
  $btween_min_sec = int(($lc_a * 60) + &argola::getrg() + 0.2);
} &argola::setopt('-min',\&opto__min_do);

sub opto__wake_do {
  &me::atnow::stayawake();
} &argola::setopt('-wake',\&opto__wake_do);

&argola::setopt('-snd',\&me::voca::custsnd);

&argola::setopt('-wf',\&me::atnow::opto__wf_do);



&argola::runopts();

# BEGIN APPROVAL SCANS:

# Is there enough minimal time between chimes?
if ( $btween_min_sec < 9.5 )
{
  die "\nmindful-bell-main: FATAL ERROR:\n" .
    "    A minimum-interval below 10-seconds is unsupported.\n" .
  "\n";
}

# Is there enough leeway?
if ( ( $btween_avg_sec - $btween_min_sec ) < 9.5 )
{
  die "\nmindful-bell-main: FATAL ERROR:\n" .
    "    The target-average interval between chimes must be\n" .
    "    at very least ten seconds longer than the minimal\n" .
    "    interval.\n" .
  "\n";
}




# END APPROVAL SCANS:



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





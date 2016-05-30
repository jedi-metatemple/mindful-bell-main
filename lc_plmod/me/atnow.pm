package me::atnow;
use chobaktime;
use strict;

my $wake_yes = 0;
my $wake_cmd_a;
my $wake_cmd_z;

sub init {
  my $this;
  $this = $_[0];
  $this->{'cur'} = &chobaktime::nowo();
  $this->{'nex'} = $this->{'cur'};
  $this->{'goal'} = int(($this->{'cur'} + $this->{'avg'} + 0.2) - $this->{'min'});
}

sub stayawake {
  $wake_yes = 10;
  $wake_cmd_a = '( ( chobakwrap-caff -sec ';
  $wake_cmd_z = ' ) &bg ) > /dev/null 2> /dev/null';
}

sub wakey {
  if ( $wake_yes < 5 ) { return; }
  system($wake_cmd_a . $_[0] . $wake_cmd_z);
}

sub init {
  my $this;
  $this = $_[0];
  $this->{'cur'} = &chobaktime::nowo();
  $this->{'nex'} = $this->{'cur'};
  $this->{'goal'} = int(($this->{'cur'} + $this->{'avg'} + 0.2) - $this->{'min'});
}

sub rwind {
  my $this;
  my $lc_now;
  my $lc_dif;
  $this = $_[0];
  $lc_now = &chobaktime::nowo();
  $lc_dif = int(($this->{'cur'} - $lc_now) + 0.2);
  $this->{'cur'} = $lc_now;
  $this->{'goal'} = int(($this->{'goal'} - $lc_dif) + 0.2);
  $this->{'nex'} = int(($this->{'nex'} - $lc_dif) + 0.2);
}

sub advan {
  my $this;
  my $lc_mfwd;
  my $lc_rawfwd;
  $this = $_[0];
  $this->{'cur'} = $this->{'nex'};
  $this->{'goal'} = int($this->{'goal'} + $this->{'avg'} + 0.2);
  $lc_mfwd = int(($this->{'goal'} - ( $this->{'cur'} + $this->{'min'} ) ) + 0.2 );
  $lc_rawfwd = rand($lc_mfwd);
  $this->{'nex'} = int($this->{'cur'} + $this->{'min'} + $lc_rawfwd);
}

sub waittime {
  my $this;
  my $lc_for;
  my $lc_now;
  my $lc_til;
  my $lc_slp;
  $this = $_[0];
  $lc_for = $this->{'nex'};
  $lc_now = &chobaktime::nowo();
  while ( $lc_now < $lc_for )
  {
    $lc_slp = 1;
    $lc_til = int(($lc_for - $lc_now) + 0.2);
    
    #system("echo","TILL: " . $lc_til);
    
    if ( $lc_slp > 10.5 )
    {
      $lc_slp = 5;
    }
    &wakey(20);
    sleep($lc_slp);
    $lc_now = &chobaktime::nowo();
  }
}


1;

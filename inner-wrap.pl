use strict;

# Minimum Interval of Chime Sequences
my $btween_min_sec = 40;
# -- minimum value = 20

# Target-Average Interval of Chime Sequences
my $btween_avg_sec = 300;
# -- minimum value is double $btween_min_sec

# Pre-Initial Convergence Rounds Remaining
my $preinit_rounds_rm = 40;
# This variable is important so that the earlier
# chimes won't be too predictable.


# Mode option(s) to chobakwrap-caff:
my @chobak_caff_opt = ( '-full' );




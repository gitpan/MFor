use Test::More tests => 73;
BEGIN { use_ok('MFor') };


use MFor;

my $output = '';
open FH , ">" , \$output;
mfor {
  print FH join( '-' , @_ ) . "\n";
} [
    [ 1 .. 6 ],
    [ qw/a b c/ ],
    [ 'a' .. 'd' ],
];
close FH;

my @lines = split /\n/ , $output;
# warn Dumper( @lines );use Data::Dumper;

for my $e1 ( 1 .. 6 ) {
  for my $e2 ( qw/a b c/ ) {
    for my $e3 ( 'a' .. 'd' ) {
      my $line = shift @lines;
      chomp $line;
      is( $line , join('-',$e1,$e2,$e3) );
    }
  }
}

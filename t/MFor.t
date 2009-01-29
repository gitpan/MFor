use Test::More tests => 7801;
BEGIN { use_ok('MFor') };


use MFor;

my $output = '';
open FH , ">" , \$output;
mfor {
  print FH join( '-' , @_ ) . "\n";
} [
    [ 1 .. 3 ],
    [ 1 .. 10 ],
    [ 1 .. 10 ],
    [ 'a' .. 'z' ],
];
close FH;

my @lines = split /\n/ , $output;
# warn Dumper( @lines );use Data::Dumper;

for my $e1 ( 1 .. 3 ) {
  for my $e2 ( 1 .. 10 ) {
    for my $e3 ( 1 .. 10 ) {
      for my $e4 ( 'a' .. 'z' ) {
        my $line = shift @lines;
        chomp $line;
        is ( $line, join ( '-', $e1, $e2, $e3, $e4 ) );
      }
    }
  }
}

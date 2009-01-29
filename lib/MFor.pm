package MFor;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(&mfor);
our $VERSION = '0.03';

sub mfor(&@);
sub mfor(&@) {
  my $cr = shift;
  my $arrs = shift;
  my ($arr_lev,$arr_idx) = @_ if ( @_ );

  $arr_lev ||= 0;
  my $arr_sz = scalar(@$arrs);
  unless ($arr_idx) {
    push @$arr_idx,0 for ( 1 .. $arr_sz  );
  }
  my $cur_arr = $arrs->[ $arr_lev ] ;
  my $idx     = scalar(@$cur_arr);
  if( $arr_sz == $arr_lev + 1 ) {
    my @args = ();
    my $tlev = 0;
    push @args , $arrs->[ $tlev++ ]->[ $_ ] for ( @$arr_idx );
    for my $i ( 0 .. $idx-1 ) {
      $args[ $tlev - 1 ] = $arrs->[ $tlev - 1 ]->[ $i ];
      $cr->( @args );
    }
  } 
  else {
    for my $i ( 0 .. $idx-1  ) {
      $arr_idx->[ $arr_lev ] = $i ;
      mfor { &$cr } $arrs,$arr_lev + 1,$arr_idx;
    }
    $arr_idx->[ $arr_lev ] = 0 ;
  }
}
1;

__END__

=head1 NAME

MFor - A module for multi-dimension looping.

=head1 SYNOPSIS

  use MFor;
  mfor {
      my @args = @_;  # get a,x,1 in first loop
      print "Looping..  " , join(',',@_) , "\n";
  }  [
       [ qw/a b c/ ],
       [ qw/x y z/ ],
       [ 1 .. 7 ],
  ];

insteads of:

  for my $a ( qw/a b c/ ) {
    for my $b ( qw/x y z/ ) {
      for my $c (  1 .. 7 ) {
        print "Looping..  " , join(',',$a,$b,$c) , "\n";
      }
    }
  }


=head1 DESCRIPTION

This module provides another way to do loop. 

=head2 EXPORT

mfor

=head1 SEE ALSO

=head1 AUTHOR

Lin Yo-An, E<lt>cornelius.howl@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by c9s

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut

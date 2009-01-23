package MFor;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(&mfor);
our $VERSION = '0.02';

sub mfor(&@);
sub mfor(&@) {
  my $c_r = shift;
  my $arrs = shift;

  my $arr_lev = shift if ( @_ );
  my $arr_idx = shift if ( @_ );

  $arr_lev ||= 0;
  unless ($arr_idx) {
    push @$arr_idx,0 for ( 1 .. scalar @$arrs );
  }
  my $arr_size = scalar(@$arrs);
  if( $arr_size == $arr_lev + 1 ) {
    my $cur_arr = $arrs->[ $arr_lev ] ;
    my $idx     = scalar(@$cur_arr);
    for my $i ( 0 .. $idx-1 ) {
      $arr_idx->[ $arr_lev ] = $i ;
      my ($lev,@args) ;
      $lev = 0;
      push @args , $arrs->[ $lev++ ]->[ $_ ] for ( @$arr_idx );
      $c_r->(  @args  );
    }
    $arr_idx->[ $arr_lev ] = 0 ;
  } 
  else {
    my $cur_arr = $arrs->[ $arr_lev ];
    my $idx = scalar(@$cur_arr);
    for my $i ( 0 .. $idx-1  ) {
      $arr_idx->[ $arr_lev ] = $i ;
      mfor { &$c_r } $arrs,$arr_lev + 1,$arr_idx;
    }
    $arr_idx->[ $arr_lev ] = 0 ;
  }
}
1;

__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

MFor - A moudle for multi-dimension looping.

=head1 SYNOPSIS

  use MFor;
  mfor {
      my @args = @_;  # get a,x,1 in first loop
      print "Looping..  " , join(',',@_) , "\n";
  }  [
       [ qw/a b c/ ],
       [ qw/x y z/ ],
       [ qw/1 2 3 4 5 6 7/ ],
  ];

instead of:

  for my $a ( qw/a b c/ ) {
    for my $b ( qw/x y z/ ) {
      for my $c ( qw/1 2 3 4 5 6 7/ ) {
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


use strict;
use warnings;
use Data::Dumper;

my $gridx  = 10;
my $gridy  = 10;

my $pixel  = '.';
my $x1 = 1;
my $y1 = 2;
my $x2 = 8;
my $y2 = 2;

my $gr = draw_line( $x1 , $y1 , $x2 , $y2 , 0 , $pixel , $gridx , $gridy );
draw_pixels_on_screen( $gr , $gridx , $gridy );

$x1 = 3;
$y1 = 1;
$x2 = 3;
$y2 = 7;
$gr = draw_line( $x1 , $y1 , $x2 , $y2 , 0 , $pixel , $gridx , $gridy );
draw_pixels_on_screen( $gr , $gridx , $gridy );

$x1 = 2;
$y1 = 3;
$x2 = 7;
$y2 = 9;
$gr = draw_line( $x1 , $y1 , $x2 , $y2 , 0 , $pixel , $gridx , $gridy );
draw_pixels_on_screen( $gr , $gridx , $gridy );


sub draw_line{

    my ( $x1 , $y1 , $x2 , $y2 , 
         $yaxisintercept , 
         $pixel , $gridx , $gridy ) = @_;

    my @grid;

    my $i = 0;
    my $j = 0;
    for( $i = 0 ; $i <= $gridx ; $i++ ){
        for( $j = 0 ; $j <= $gridy ; $j++ ){
            $grid[$i][$j] = " ";
        }
    }

    if( ( $x2 == $x1 ) && ( $y2 == $y1 ) ){

        $grid[$x2][$y2] = $pixel;

    }elsif( $x2 == $x1 ){

        #for a vertical line slope is undefined
        while( $y2 != $y1 ){

            $grid[$x1][$y1] = $pixel;
            $y1++;

        }

    }elsif( $y2 == $y1 ){

        $yaxisintercept = $y2;
        
        while( $x2 != $x1 ){

            $grid[$x1][$y1] = $pixel;
            $x1++;

        }


    }else{

        my $slope = find_slope( $x1 , $y1 , $x2 , $y2 );
        
        $slope = int( $slope + 0.5 ); #breaks when this line is commented
        
        while( $x1 != $x2 ){

            my $x = $x1;
            my $y = ( $slope * $x ) + $yaxisintercept;

            $grid[$x][$y] = $pixel;
            $x1++;
        }

    }

    return \@grid;
}

sub find_slope{
    my ( $x1 , $y1 , $x2 , $y2 ) = @_;


    #Note y = mx + c is the equation of a line 

    # Given two equations (y1) = m(x1) + c and (y2) = m(x2) + c
    # Subtracting second equation from first you get m as 


    my $m = ( $y2 - $y1 ) / ( $x2 - $x1 ) ;

    return $m;
}

sub draw_pixels_on_screen{
    my ( $grid_values , $x_axis_limit , $y_axis_limit ) = @_;

    my @grid = @$grid_values;

    my $x = 0;
    my $y = 0;

    for( $x = $x_axis_limit ; $x >= 0 ; $x-- ){
        for( $y = 0 ; $y <= $y_axis_limit ; $y++ ){
            print $grid[$y][$x];
        }
        print "\n";
    }
}


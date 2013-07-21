#! /usr/bin/perl 
$numArgs = $#ARGV + 1;
#open file
@dum = split( "\\.", $ARGV[0] );
$root = @dum[0];
print "$ARGV[0] $root\n";
open(SPTR,"<$ARGV[0]") or die("Unable to open file");
while( $line = <SPTR> )
{
	print $line;
}
#close file
close(SPTR);
$nVar = @data;
printf "Number of data lines %d\n", $nVar;
open(OUTB,">$root-sptr2.plt") or die("Unable to open file");
for( $i = 0; $i < $nVar; $i++ )
{
	@dum = split( /[, \n]+/, @data[$l] );
	$name = lc( @dum[2] );
	print $i + 1, " ", $name, " ";
	@p1 = split( /[, ]+/, @data[$l+1]);
	@p2 = split( /[, ]+/, @data[$l+2]);
	@p3 = split( /[, ]+/, @data[$l+3]);
	@p4 = split( /[, ]+/, @data[$l+4]);
#	printf "%g %g\n", @p1[0], @p1[1];
#	printf "%g %g\n", @p2[0], @p2[1];
#	printf "%g %g\n", @p3[0], @p3[1];
#	printf "%g %g\n", @p4[0], @p4[1];
        $y1dx = (@p4[0]-@p1[0]);
        $y1dy = (@p4[1]-@p1[1]);
        $y1 = sqrt( $y1dx * $y1dx + $y1dy * $y1dy );
        $y2dx = (@p3[0]-@p2[0]);
        $y2dy = (@p3[1]-@p2[1]);
        $y2 = sqrt( $y2dx * $y2dx + $y2dy * $y2dy );
        $y = ( $y2 + $y1 ) / 2;
        $x1dx = (@p2[0]-@p1[0]);
        $x1dy = (@p2[1]-@p1[1]);
        $x1 = sqrt( $x1dx * $x1dx + $x1dy * $x1dy );
        $x2dx = (@p4[0]-@p3[0]);
        $x2dy = (@p4[1]-@p3[1]);
        $x2 = sqrt( $x2dx * $x2dx + $x2dy * $x2dy );
        $x = ( $x2 + $x1 ) / 2;
        printf "%.2f %.2f : ", $x, $y;
        $nx = to_int( $x / $g );
        $ny = to_int( $y / $g );
        $nn = $nx * $ny;
        $pp += $nn;
        print "$nx $ny : $nn\n";
        printf OUTID "%d %s %d\n", $i + 1, $name, $nn;

        $filename = "$name\.sptr-coord";
        open(OUT,">$filename") or die("Unable to open file");
	@o1 = @p1;
	@o2 = @p2;
	$y1dx = (@p4[0]-@p1[0])/($ny-1);
	$y1dy = (@p4[1]-@p1[1])/($ny-1);
	$y2dx = (@p3[0]-@p2[0])/($ny-1);
	$y2dy = (@p3[1]-@p2[1])/($ny-1);
	for( $k = 0; $k < $ny; $k++ )
	{
		$xdx = (@o2[0]-@o1[0])/($nx-1);
		$xdy = (@o2[1]-@o1[1])/($nx-1);
		for( $j = 0; $j < $nx; $j++ )
		{
			printf OUTB "%d %g %g 5\n", $i + 1, @o1[0]+$xdx*$j, @o1[1]+$xdy*$j;
			printf OUT "%d %g %g 5\n", $i + 1, @o1[0]+$xdx*$j, @o1[1]+$xdy*$j;
		}
		@o1[0]+=$y1dx;
		@o1[1]+=$y1dy;
		@o2[0]+=$y2dx;
		@o2[1]+=$y2dy;
	}
	$l+=6;
        printf OUT "\n";
        close(OUT);
} 
print "Total particles $pp\n";
printf OUTB "\n";
close(OUTB);
close(OUTID);

sub to_int ($) {
       return unless defined $_[0] && $_[0] ne '';
       my ($num) = $_[0] =~ /([+-]?(?:\d+(?:\.\d*)?|\.\d+))/;
       return unless defined $num;
       sprintf "%.0f", $num;
}

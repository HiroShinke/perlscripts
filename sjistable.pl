

use Encode;
use Getopt::Long;

my $encoding = "utf-8";

GetOptions(
    "e=s" => \$encoding
    );

for(my $x = 0x8140; $x <= 0xfff0; $x++ ){
    my $str = pack("n",$x);
    if( $encoding eq "raw" ){
	eval {
	    my $str2 = $str;
	    my $ustr = decode("MS932",$str2,Encode::FB_CROAK);    
	    printf("%02x:1:%s\n", $x, $str);
	};
	if( $@ ){
	    printf("%02x:0:%s\n", $x, $str);
	}

    } else {
	eval {
	    my $ustr = decode("MS932",$str,Encode::FB_CROAK);    
	    printf("%02x:1:%s\n", $x, encode($encoding,$ustr));
	};
	if( $@ ){
	    printf("%02x:0:--\n",$x);
	}
    }
}



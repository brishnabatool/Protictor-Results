byte x;
byte opt = 0;

init
{
	x = 1;
	do
		::	opt = 1
		::	opt = 10
		::	x = 7
	od;
}

ltl p0 {[](x <= 4)}




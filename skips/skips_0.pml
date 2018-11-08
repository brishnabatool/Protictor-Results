byte x = 2 , y = 1;
byte z = 10 , c = 0;

init 
{
	run A();
}


proctype A() 
{
		x = 2;

		if
			::	(y < x) &&
			!(c == 0 && x == 2 && y == 1 && z == 10)
					x = 7;
			::	(y < x)
					x = 2
					skip;
			:: 	else
					skip;
					z = 7
		fi
		y = x;
}

ltl p0 {[](y < 3)}


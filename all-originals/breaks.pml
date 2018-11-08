byte x = 1 , y = 1;
byte c = 0;

init 
{
	run A();
}


proctype A() 
{
	do
		:: 	(c < 100) ->
				x = 3;
				break;


		::  (c < 100) ->
				c = 0;
				y = 3;
				x++;
	od

	
}

ltl p0 {[](y < 2)}


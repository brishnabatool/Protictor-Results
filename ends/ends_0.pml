byte x = 4;
byte a = 3;
byte b = 3;
byte opt = 0;

init
{
/*	run A();*/
	run A();
}

proctype A()
{

	run B();

	if
		:: (a < b) -> 
					opt = 1
		:: (a == b) ->		
					opt = 3 
		:: else ->
					x = 7
	fi;

	a = 10;
}

proctype B()
{

	atomic
	{
	 	!(a == 3 && b == 3 && opt == 0 && x == 4)
	 	a = 10;
	}
}


ltl p0 {[](x == 4)}




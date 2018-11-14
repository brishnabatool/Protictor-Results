byte in1, in2;
byte a, b, quo, rem;
bit load = 0, dne = 1;
proctype quo_rem()
{
	do
		::	(load == 1) -> 
				a = in1; 
				b = in2;
				quo = 0; 
				rem = a; 
				atomic
				{
				 	!(a == 7 && b == 2 && dne == 0 && in1 == 7 && in2 == 2 && load == 1 && quo == 0 && rem == 7)
				 	dne = 0;
				}
		::	(load != 1) -> 
				if
             	    ::	(rem >= b) -> 
             	    		rem = rem-b;
                        	quo = quo+1;
	                ::	(b > rem) -> 
	                		dne = 1 
				fi
	od	
}
proctype env()
{
	in1 = 7; 
	in2 = 2; 
	load = 1;
	/* init inputs */
	dne == 0; 
	load = 0; 
	dne == 1; /* read results */
	
}
init 
{ 
	atomic
	{
		run quo_rem(); 
		run env() 
	}
}


ltl p0 {[]((load == 1 && in1 == a && in2 == b) -> 
        <> (dne == 1 && a == ((quo * b) + rem)))}

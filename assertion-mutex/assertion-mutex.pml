byte in;
byte x, y, z;

proctype user()	/* file ex.4c */
{	
	byte me;
	me = _pid+1;			/* me is 1 or 2 */
L1:	
	x = me;
L2:	
	if
		:: (y != 0 && y != me) -> 
			goto L1	/* try again */
		:: (y == 0 || y == me)
	fi;
L3:	
	z = me;
L4:	
	if
		:: (x != me)  -> 
			goto L1		/* try again */
		:: (x == me)
	fi;
L5:	
	y = me;
L6:	
	if
		:: (z != me) -> 
			goto L1			/* try again */
		:: (z == me)
	fi;
L7:						/* success */
	in = in+1;
	in = in - 1;
	goto L1
}

init
{
	atomic
	{
		run user();
		run user();
	}
}

ltl {([]<>(in == 1))}
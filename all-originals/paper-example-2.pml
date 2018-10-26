byte x;

init
{
	x = 0;
l0:
 	if
		:: (x == 0) ->
			x = x + 1	/* [a] */
			goto l1
	fi
		
l1:
 	if
		:: x = 0		/* [d] */
		   goto l0
		:: x = x - 1	/* [b] */
		   goto l2
		:: (x == 1) ->
			x = 2 * x	/* [c] */
			goto l3
	fi

l2: 
	if
		:: (x == 2) ->
			x = x - 1	/* [b] */
			goto l0
		:: (x == 0) ->
			x = x + 1	/* [a] */
			goto l1
	fi

l3: 
	if
		:: (x == 2) ->
			x = x - 1	/* [b] */
			goto l1
	fi


}

ltl p0 {[]<>(x == 2)}




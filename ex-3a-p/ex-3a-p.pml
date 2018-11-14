/* This file has been modified from the SPIN examples */

bool b[2]				// Boolean array b(0;1) integer k, i, j
bool p[2];

init
{
	atomic
	{
		run P();
		run P();
	}
}
proctype P()			// comment process i
{	
	pid k, i, j			// with i either 0 or 1 and j = 1-i;
	i = _pid;
	j = 5 -_pid;

C0:	
	b[i-1] = false			// C0:	b(i) := false;
C1:	
	if
		:: k != i-1			// C1:	if k != i then begin
C2:		   
			if
			   	:: !b[j-1] -> 
			   			goto C2		// C2:	if not (b(j) then go to C2;
			   	:: else -> 
			   			k = i-1; 
		   				goto C1	// else k := i; go to C1 end;
		   	fi
		:: else ->
				p[_pid-1] = true;		// else critical section;
	fi
	p[_pid-1] = false
	b[i-1] = true			// b(i) := true;
	skip				// remainder of program;
	goto C0				// go to C0;
}					// end

/*ltl invariant { [] (!p[0]@C3 || !p[1]@C3)}*/
ltl invariant { [] (!p[0] || !p[1])}

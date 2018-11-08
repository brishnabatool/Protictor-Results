mtype = { P,C }; 
mtype turn = P;  

proctype producer()
{
	do
		:: (turn == P) ->   
				turn = C
	od
}

proctype consumer()
{
again:
	if
		:: atomic
		   {
		   		!(turn == P)
		   		turn = P;
		   }
			goto again
	fi
}

init
{
	atomic
	{
		run producer();
		run consumer();
	}
}

ltl {(([]<> (turn == P)) && ([]<> (turn == C)))}

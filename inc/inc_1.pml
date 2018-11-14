mtype = {three , one , two}
mtype count = one;
bool incr;

proctype counter() {
	do
	:: incr ->
	      count = ((count + 1)%3) + 1
od
}

proctype env() {
	do
		:: atomic
		   {
		   		!(count == one && incr == 0) &&
		   		!(count == two && incr == 0)
		   		incr = false
		   }
		:: incr = true
	od
}
init 
{
	atomic
	{
		run counter();
		run env();
	}	
}

ltl p0 { ([]<> (incr) )}

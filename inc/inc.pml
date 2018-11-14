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
		:: incr = false
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

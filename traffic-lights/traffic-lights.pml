mtype = {red, yellow, green};
mtype light=green;
ltl p0 {[]<> (light==green)}

init {
	run lights();
}

proctype lights()
{
	do
	:: if
	   :: light==red -> 
	   				light=green;
	   :: light==yellow -> 
	   				light=red;
	   :: light==green -> 
	   				light=yellow;
	   :: light == red -> 
	   				light = red;
	   fi;
	od

}

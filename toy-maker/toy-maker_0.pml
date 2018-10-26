mtype = {Order, Cut, Assemble, Paint, Deliver}
mtype Stage;
init 
{
	run TM();	 
}


proctype TM()
{
	Stage = Order;
	do
	::	Stage = Cut;
		if 
		:: Stage = Assemble;
		:: atomic
		   {
		   		!(Stage == Cut)
		   		Stage = Paint;
		   }
		fi;
		
		if :: (Stage == Assemble) -> Stage = Paint 
		fi
		
		Stage = Deliver;
		Stage = Order;
		
	od
}
ltl  {[]<> (Stage == Assemble)} 
/*ltl  {<> (Stage == Assemble)} */
/* never {[](Stage != Assemble)} */

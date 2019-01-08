mtype = {Order, Cut, Assemble, Paint, Deliver}
/*mtype Stage;*/
chan c = [2] of {mtype,byte};
chan e = [2] of {byte};
chan e2 = [2] of {byte};
chan f = [2] of {byte};
byte gx = 0;

init 
{
	run TM();	
/*	run A(); */
}


proctype TM()
{
	e!3;
	e?3;
	e2!3;
	e2?3;
	f!1;
	f!2;
	
	mtype Stage;
	c!Order,1;
	do
	::	c?Stage,gx
		c!Cut,2;
		if 
		::	c?Stage,gx
			c!Assemble,3;						
		::	c?Stage,gx			
			c!Paint,4;
		fi;
		
		if	
			::	c?Stage,gx;
				(Stage == Assemble) -> 
				c!Paint,4 				
		fi
		
		c?Stage,gx
		c!Deliver,5;

		c?Stage,gx
		c!Order,1;
	od
}

/*
proctype A()
{
	do  
		:: skip;
		:: break;
	od;
}
*/
/*ltl  {[]<> (Stage == Assemble)} */
ltl  {[]<> (c?[Assemble])} 
/*ltl  {<> (Stage == Assemble)} */
/* never {[](Stage != Assemble)} */

#define true	1
#define false	0
#define Aturn	false
#define Bturn	true

bool x, y, t;
bool ain, bin;

proctype A()
{	x = true;
	t = Bturn;
	atomic
	{
	 	!(ain == 0 && bin == 1 && t == 1 && x == 1 && y == 1)
	 	ain = true;
	}
	/* critical section */
	ain = false;
	x = false
}

proctype B()
{	y = true;
	t = Aturn;
	bin = true;
	/* critical section */
	bin = false;
	y = false
}

init
{	
	atomic
	{	
		run A(); 
		run B()
	}
}

ltl {([]((ain -> !bin) && (bin -> !ain)))}

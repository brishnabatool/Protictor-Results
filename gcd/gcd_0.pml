int a, b;

init 
{
	int x, y;
	x=15;
	y=20;
	a=x;
	b=y;
	
	do
		:: a>b -> 
				a=a-b
		:: b>a -> 
				b=b-a
		:: b>a  &&
		   !(a == 15 && b == 20)->
				break
		:: a==b -> 
				break
	od;
}

ltl {(<>[](a == b))}

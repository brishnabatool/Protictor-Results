byte x = 2;
byte a = 4;
byte b = 3;

init
{

L1:	do
	::	goto L4;
	::	goto L6
	od;

L2: goto L5;

L3: x = 7;
goto L6;

L4: do
        ::  atomic
            {
            		!(a == 4 && b == 3 && x == 2)
            		goto L2
            }
        ::  a = 2
    od;


L5: goto L3;

L6: skip;
}

ltl p0 {[]<>(x == 2)}




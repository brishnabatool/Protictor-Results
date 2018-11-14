byte choosing[2];
byte number[2];

proctype P_0() 
{ 
	byte j=0;
	byte max=0;

NCS: 
	if
		::  atomic
			{
				atomic
				{
				 	!(choosing[0] == 0 && choosing[1] == 0 && number[0] == 0 && number[1] == 9)
				 	choosing[0] = 1;
				}
				j = 0;
				max = 0;
			} 
			goto choose; 

	fi;
choose: 
	if
		::  atomic
			{
				j<2 && number[j]>max &&
				!(choosing[0] == 1 && choosing[1] == 0 && number[0] == 0 && number[1] == 9);
				max = number[j];
				j = j+1;
			}  
			goto choose; 

		::  atomic
			{
				j<2 && number[j]<=max;
				j = j+1;
			} 
			goto choose; 

		::  atomic
			{
				j==2 && max<9;
				number[0] = max+1;
				j = 0;
				choosing[0] = 0;
			} 
			goto for_loop; 

	fi;
for_loop: 
	if
		:: j<2 && choosing[j]==0;
			goto wait; 

		:: j==2;
			goto CS; 

	fi;
wait: 
	if
		::  atomic
			{
				number[j]==0 || (number[j]>number[0]) || (number[j]==number[0] && 0<=j);
				j = j+1;
			}  
			goto for_loop; 

	fi;
CS: 
	if
		:: number[0] = 0;
			goto NCS; 

	fi;
}

proctype P_1() { 
byte j=0;
byte max=0;

NCS: if
::  atomic
 {
		choosing[1] = 1;
		j = 0;
		max = 0;
		}
		goto choose; 

fi;
choose: if
::  atomic
 {
		j<2 && number[j]>max;
		max = number[j];
		j = j+1;
		}
		goto choose; 

::  atomic
 {
		j<2 && number[j]<=max;
		j = j+1;
		} 
		goto choose; 

::  atomic
 {
		j==2 && max<9 &&
		!(choosing[0] == 1 && choosing[1] == 1 && number[0] == 0 && number[1] == 0);
		number[1] = max+1;
		j = 0;
		choosing[1] = 0;
		} 
		goto for_loop; 

fi;
for_loop: if
:: j<2 && choosing[j]==0;
	goto wait; 

:: j==2;
	goto CS; 

fi;
wait: if
::  atomic
 {
	number[j]==0 || (number[j]>number[1]) || (number[j]==number[1] && 1<=j);
	j = j+1;
	}
	goto for_loop; 

fi;
CS: if
:: number[1] = 0;
	goto NCS; 

fi;
}

init 
{
	atomic
	{
		run P_0();
		run P_1();
	}
}


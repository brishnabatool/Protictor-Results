bool lockA = false;
bool lockB = false;

init 
{
	run thread();
	run thread();
}

proctype thread()
{
	do 
		:: true ->
				atomic
				{
					lockA == false;
					lockA = true;
				}	
				atomic
				{
					lockB == false;
					lockB = true;
				}	

				printf("AB")

				lockA = false;
				lockB = false;

		:: true ->
				atomic
				{
					lockB == false;
					lockB = true;
				}	
				atomic
				{
					lockA == false;
					lockA = true;
				}	

				printf("BA")

				lockB = false;
				lockA = false;

	od
}


ltl p0 {([]<>(lockA == 0)) || ([]<>(lockB == 0))}

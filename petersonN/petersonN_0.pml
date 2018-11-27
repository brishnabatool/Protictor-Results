/* Peterson's algorithm for N processes - see Lynch's book, p. 284 */

#define N	5	/* nr of processes */

byte turn[N], flag[N];

byte ncrit;	/* auxiliary var to check mutual exclusion */

init
{
	int c = 0;
	atomic
	{	
		do
			:: c < N  &&
			   !(flag[0] == 0 && flag[1] == 0 && flag[2] == 0 && flag[3] == 0 && flag[4] == 0 && ncrit == 0 && turn[0] == 0 && turn[1] == 0 && turn[2] == 0 && turn[3] == 0 && turn[4] == 0)->
				run user();
			:: else ->
				break;
		od
	}
}

proctype user()
{	byte j, k;
	/* the _pid's are: 0 .. N-1 */
again:
	k = 0;	/* count max N-1 rounds of competition */
	do
	:: k < N-1 ->
		flag[_pid] = k;
		turn[k] = _pid;

		j = 0;		/* for all j != _pid */
		do
		:: j == _pid ->
			j++
		:: j != _pid ->
			if
			:: j < N ->
				/*(flag[j] < k || turn[k] != _pid);*/
				j++
			:: j >= N  ->
				break
			fi
		od;
		k++
	:: else ->	/* survived all N-1 rounds */
		break
	od;

	ncrit++;
cs:	
	/* critical section */
	ncrit--;

	flag[_pid] = 0;
	goto again
}

ltl {[](ncrit <= 1)}
/*ltl bounded_bypass { user[1]@again -> <> user[1]@cs }*/

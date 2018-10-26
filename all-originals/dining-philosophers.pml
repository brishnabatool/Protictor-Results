byte N = 3
bit fork[N];
byte nr_eat;

init 
{
	atomic 
	{
		byte i = 0;

		#if (SOL == 1)
		do
			:: i < N-1 -> 
					run Philosopher(i); i++;
			:: else    -> 
					run Phil_another(i); break;
		od;
		#else
		#if (SOL == 2)
		do
			:: i < N-1 -> 
					run Philosopher(i); i++;
			:: else    -> 
					run Phil_restart(i); break;
		od;
		#else /* (SOL == 0 || SOL == 'invalid') */
		do
			:: i < N -> 
					run Philosopher(i); i++;
			:: else  -> 
					break;
		od;
		#endif /* SOL == 2 */
		#endif /* SOL == 1 */
	}
}


proctype Philosopher(byte id) 
{
Think:
	atomic 
	{ 
		fork[id] == 0-> 
		fork[id] = 1; 
	}
One:
	atomic 
	{ 
		fork[(id + 1)%N] == 0 -> 
		fork[(id + 1)%N] = 1; 
		nr_eat++; 
	};
Eat:
	atomic 
	{ 
		nr_eat--; 
		fork[(id + 1)%N] = 0; 
	}
	fork[id] = 0;
	goto Think;
}

proctype Phil_another(byte id) 
{
Think:
	atomic 
	{ 
		fork[(id + 1)%N] == 0 -> 
		fork[(id + 1)%N] = 1; 
	};
One:
	atomic 
	{ 
		fork[id] == 0-> 
		fork[id] = 1; 
		nr_eat++; 
	}
Eat:
	atomic 
	{ 
		nr_eat--; 
		fork[id] = 0; 
	}
	fork[(id + 1)%N] = 0;
	goto Think;
}


proctype Phil_restart(byte id) 
{
Think:
	atomic 
	{ 
		fork[id] == 0-> 
		fork[id] = 1; 
	}
One:
	if
		:: atomic 
		   	{ 
		   		fork[(id + 1)%N] == 0 -> 
		   		fork[(id + 1)%N] = 1; 
		   		nr_eat++; 
	   		};
		:: atomic 
		   	{ 
		   		fork[(id + 1)%N] != 0 -> 
		   		fork[id] = 0; 
	   		} 
	   		goto Think;
	fi;
Eat:
	atomic 
	{ 
		nr_eat--; 
		fork[(id + 1)%N] = 0; 
	}
	fork[id] = 0;
	goto Think;
}

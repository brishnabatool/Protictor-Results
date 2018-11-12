#define NUMPROCS 2

byte counter = 0;
byte progress[NUMPROCS];
int sum = 0;

proctype incrementer(byte me)
{
  int temp;

  temp = counter;
  counter = temp + 1;
  atomic
  {
   	!(counter == 1 && progress[0] == 0 && progress[1] == 1 && sum == 0)
   	progress[me] = 1;
  }
}

init {
  int i;
  i = 0;

  atomic {
    i = 0;
    do
      :: i < NUMPROCS ->
          progress[i] = 0;
          run incrementer(i);
          i++
      :: i >= NUMPROCS ->
          break
    od;
  }
  atomic 
  {
    i = 0;
    sum = 0;
    do
      :: i < NUMPROCS ->
         sum = sum + progress[i];
         i++
      :: i >= NUMPROCS ->
          break
    od;
    /*assert(sum < NUMPROCS || counter == NUMPROCS)*/
  }
}

ltl {(<>[](sum < NUMPROCS || counter == NUMPROCS))}

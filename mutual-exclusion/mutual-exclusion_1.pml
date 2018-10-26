bool turn, flag[2];
byte ncrit;

init
{
  run user(0)
  run user(1)
}


proctype user(byte pno)
{
do 
::
    flag[pno] = 1;
    turn = 1 - pno; 
    atomic
    {
     	!(flag[0] == 1 && flag[1] == 1 && ncrit == 1 && turn == 0) &&
     	!(flag[0] == 1 && flag[1] == 1 && ncrit == 1 && turn == 1)
     	ncrit++;
    }
    /* critical section */
    ncrit--;

    flag[pno] = 0;   
od
}

ltl p0  { []((ncrit >= 0) && (ncrit <= 1))} 

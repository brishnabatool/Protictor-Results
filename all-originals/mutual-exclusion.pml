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
    ncrit++;
    /* critical section */
    ncrit--;

    flag[pno] = 0;   
od
}

ltl p0  { []((ncrit >= 0) && (ncrit <= 1))} 

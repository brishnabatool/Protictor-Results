bit FORK0 = 0
bit FORK1 = 0
bool eating = 0;

proctype PHIL1() 
{
  atomic 
  {
    ((FORK1 == 0)) &&
    !(FORK0 == 1 && FORK1 == 0 && eating == 0) &&
    !(FORK0 == 0 && FORK1 == 0 && eating == 0);
    FORK1 = 1;
  };
  atomic 
  {
    ((FORK0 == 0));
    FORK0 = 1;
  };
  eating = true;
  FORK1 = 0;
  FORK0 = 0;
  atomic
  {
   	!(FORK0 == 0 && FORK1 == 0 && eating == 1) &&
   	!(FORK0 == 1 && FORK1 == 0 && eating == 1) &&
   	!(FORK0 == 1 && FORK1 == 1 && eating == 1) &&
   	!(FORK0 == 0 && FORK1 == 1 && eating == 1)
   	eating = false;
  }
}

proctype PHIL0() 
{
  atomic 
  {
    ((FORK0 == 0)) &&
    !(FORK0 == 0 && FORK1 == 1 && eating == 0);
    FORK0 = 1;
  };
  atomic 
  {
    ((FORK1 == 0));
    FORK1 = 1;
  };
  eating = true;
  FORK0 = 0;
  FORK1 = 0;
  eating = false;
}

init
{
	atomic
	{
		run PHIL0();
		run PHIL1();
		
	}
}

ltl {([]<>(eating == true))}

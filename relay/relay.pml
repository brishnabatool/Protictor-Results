/* bedrijfstoestandskeuze systeem IRM */
/* Peter van Eijk Sept 93 */

bool k14_1, s1_1, k12_1, h14_1;
bool k14_2, s1_2, k12_2, h14_2;
bool dienstv;
bool stable;

proctype bediening()
{
	do
		::	k14_1=1; 
			skip
		::	k14_1=0; 
			skip
		::	k14_2=1; 
			skip
		::	k14_2=0; 
			skip
		::	k12_1=1; 
			skip
		::	k12_1=0; 
			skip
		::	k12_2=1; 
			skip
		::	k12_2=0; 
			skip

		::	s1_1=1; 
			skip
		::	s1_1=0; 
			skip
		::	s1_2=1; 
			skip
		::	s1_2=0; 
			skip

		::	dienstv=1; 
			skip
		::	dienstv=0; 
			skip
	od
}

init
{	
	run bediening();
}


ltl {([]<>((
			(k14_1 == (s1_1 && !k12_1)) &&
			(k12_1 == (dienstv && (!s1_1 || k12_1))) &&
			(k14_2 == (s1_2 && !k12_2)) &&
			(k12_2 == (dienstv && (!s1_2 || k12_2))) &&
			(dienstv == (k14_1 || k14_2))  ) <= !(k14_1 && k14_2)))}
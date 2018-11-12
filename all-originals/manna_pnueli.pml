/* Alg. 5.9 Apt & Olderog book,
 * 'Manna-Pnueli central server algorithm
 */

byte cnt, request, respond

proctype server()
{
	do
	:: (request != 0) ->
		respond = request
		(respond == 0)
		request = 0
	od
}

proctype client()
{
	do
	:: respond != _pid
		request = _pid
	:: else ->
		cnt++
		/* critical section */
		cnt--
		respond = 0
	od
}

init
{
	atomic
	{
		run server();
		run client();
		run client();
	}
}

ltl {[]<>(cnt == 1)}
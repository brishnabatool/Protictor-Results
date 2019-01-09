mtype = { ini, ack, dreq, data, shutup, quiet, dead };

chan M = [1] of { mtype };
chan W = [1] of { mtype };

proctype Mproc()
{
    W!ini;                 /* connection      */
    M?ack;                 /* handshake       */

    timeout ->             /* wait            */
    if                     /* two options:    */
    :: W!shutup            /* start shutdown  */
    :: W!dreq;             /* or request data */
        M?data ->          /* receive data    */
        do
        :: atomic
           {
           		(!(M?[data]) || nempty(W)) &&
           		(!(W?[data]) || nempty(M)) &&
           		(!(W?[data] && M?[data])) &&
           		(nempty(W) || nempty(M))
           		W!data          /* send data       */
           }
           
        :: W!shutup;       /* or shutdown     */
            break
        od
    fi;

    M?shutup;              /* shutdown handshake */
    W!quiet;
    M?dead
}

proctype Wproc()
{
    W?ini;                 /* wait for ini    */
    M!ack;                 /* acknowledge     */

    do                     /* 3 options:      */
    :: W?dreq ->           /* data requested  */
        M!data             /* send data       */
    :: W?data ->           /* receive data    */
#if 1
	M!data
#else
        skip               /* no response     */
#endif
    :: W?shutup ->
        M!shutup;          /* start shutdown  */
        break
    od;

    W?quiet;
    M!dead
}

init
{
    atomic
    {
        run Wproc();
        run Mproc();
    }
}

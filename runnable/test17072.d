/*
REQUIRED_ARGS: -inline
PERMUTE_ARSG:
*/

// https://issues.dlang.org/show_bug.cgi?id=17072

import core.thread;

void main()
{
        Thread.sleep(dur!"msecs"(50));
}

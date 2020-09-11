/*
PERMUTE_ARGS: -preview=in
TEST_OUTPUT:
---
fail_compilation/diagin.d(14): Error: function `diagin.foo(in string)` is not callable using argument types `()`
fail_compilation/diagin.d(14):        missing argument for parameter #1: `in string`
fail_compilation/diagin.d(16): Error: template `diagin.foo1` cannot deduce function from argument types `!()(bool[])`, candidates are:
fail_compilation/diagin.d(20):        `foo1(T)(in T v, string)`
---
 */

void main ()
{
    foo();
    bool[] lvalue;
    foo1(lvalue);
}

void foo(in string) {}
void foo1(T)(in T v, string) {}

// Ensure that `in` has a unique mangling
static assert(foo.mangleof       == `_D6diagin3fooFIAyaZv`);
static assert(foo1!int.mangleof  == `_D6diagin__T4foo1TiZQiFNaNbNiNfIiAyaZv`);
static assert(foo1!char.mangleof == `_D6diagin__T4foo1TaZQiFNaNbNiNfIaAyaZv`);

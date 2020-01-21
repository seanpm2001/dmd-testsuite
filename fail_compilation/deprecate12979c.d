// REQUIRED_ARGS: -de
// PERMUTE_ARGS:

/* DISABLED: LDC_not_x86
TEST_OUTPUT:
---
fail_compilation/deprecate12979c.d(13): Deprecation: `asm` statement is assumed to use the GC - mark it with `@nogc` if it does not
---
*/

void foo() @nogc
{
    asm
    {
        ret;
    }
}

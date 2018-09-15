// EXTRA_CPP_SOURCES: cpp_abi_tests.cpp

extern(C++) {

struct S
{
    float a = 1;
}

extern(C++, std)
{
    struct test19248 {int a = 34;}
}

bool   passthrough(bool   value);
byte   passthrough(byte   value);
ubyte  passthrough(ubyte  value);
char   passthrough(char   value);
dchar  passthrough(dchar  value);
short  passthrough(short  value);
ushort passthrough(ushort value);
int    passthrough(int    value);
uint   passthrough(uint   value);
long   passthrough(long   value);
ulong  passthrough(ulong  value);
float  passthrough(float  value);
double passthrough(double value);
S      passthrough(S      value);
std.test19248 passthrough(const(std.test19248) value);

bool   passthrough_ptr(bool   *value);
byte   passthrough_ptr(byte   *value);
ubyte  passthrough_ptr(ubyte  *value);
char   passthrough_ptr(char   *value);
dchar  passthrough_ptr(dchar  *value);
short  passthrough_ptr(short  *value);
ushort passthrough_ptr(ushort *value);
int    passthrough_ptr(int    *value);
uint   passthrough_ptr(uint   *value);
long   passthrough_ptr(long   *value);
ulong  passthrough_ptr(ulong  *value);
float  passthrough_ptr(float  *value);
double passthrough_ptr(double *value);
S      passthrough_ptr(S      *value);
std.test19248 passthrough_ptr(const(std.test19248)* value);

bool   passthrough_ref(ref bool   value);
byte   passthrough_ref(ref byte   value);
ubyte  passthrough_ref(ref ubyte  value);
char   passthrough_ref(ref char   value);
dchar  passthrough_ref(ref dchar  value);
short  passthrough_ref(ref short  value);
ushort passthrough_ref(ref ushort value);
int    passthrough_ref(ref int    value);
uint   passthrough_ref(ref uint   value);
long   passthrough_ref(ref long   value);
ulong  passthrough_ref(ref ulong  value);
float  passthrough_ref(ref float  value);
double passthrough_ref(ref double value);
S      passthrough_ref(ref S      value);
std.test19248 passthrough_ref(ref const(std.test19248) value);
}

template IsSigned(T)
{
    enum IsSigned = is(T==byte)  ||
                    is(T==short) ||
                    is(T==int)   ||
                    is(T==long);
}

template IsUnsigned(T)
{
    enum IsUnsigned = is(T==ubyte)  ||
                      is(T==ushort) ||
                      is(T==uint)   ||
                      is(T==ulong);
}

template IsIntegral(T)
{
    enum IsIntegral = IsSigned!T || IsUnsigned!T;
}

template IsFloatingPoint(T)
{
    enum IsFloatingPoint = is(T==float) || is(T==double) || is(T==real);
}

template IsBoolean(T)
{
    enum IsBoolean = is(T==bool);
}

template IsSomeChar(T)
{
    enum IsSomeChar = is(T==char) || is(T==dchar);
}

void check(T)(T actual, T expected)
{
    assert(actual is expected);
}

void check(T)(T value)
{
    check(passthrough(value), value);
    check(passthrough_ptr(&value), value);
    check(passthrough_ref(value), value);
}

T[] values(T)()
{
    T[] values;
    static if(IsBoolean!T)
    {
        values ~= true;
        values ~= false;
    }
    else static if(IsSomeChar!T)
    {
        values ~= T.init;
        values ~= T('a');
        values ~= T('z');
    }
    else
    {
        values ~= T(0);
        values ~= T(1);
        static if(IsIntegral!T)
        {
            static if(IsSigned!T) values ~= T.min;
            values ~= T.max;
        }
        else static if(IsFloatingPoint!T)
        {
            values ~= T.nan;
            values ~= T.min_normal;
            values ~= T.max;
        }
        else
        {
            assert(0);
        }
    }
    return values;
}

void main()
{
    foreach(bool val; values!bool())     check(val);
    foreach(byte val; values!byte())     check(val);
    foreach(ubyte val; values!ubyte())   check(val);
    foreach(char val; values!char())     check(val);
    foreach(dchar val; values!dchar())   check(val);
    foreach(short val; values!short())   check(val);
    foreach(ushort val; values!ushort()) check(val);
    foreach(int val; values!int())       check(val);
    foreach(uint val; values!uint())     check(val);
    foreach(long val; values!long())     check(val);
    foreach(ulong val; values!ulong())   check(val);
    foreach(float val; values!float())   check(val);
    foreach(double val; values!double()) check(val);
    check(S());
    check(std.test19248());
}

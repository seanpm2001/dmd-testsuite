// PERMUTE_ARGS:
// REQUIRED_ARGS:

import std.stdio;

struct A(Args...) {
    pragma(msg, "TEST: base use case");
    Args[0].T mBase;
    pragma(msg, "TEST: chained types");
    Args[0].T.TT mChain;
    pragma(msg, "TEST: chained packs");
    Args[1+1].FArgs[0] mChainPack;
    pragma(msg, "TEST: expr");
    int mExpr = Args[1].i;
    pragma(msg, "TEST: Nested + index eval");
    Args[Args[0].i2].T mNested;

    // Aliases.
    pragma(msg, "TEST: alias, base use case");
    alias UBase = Args[0].T;
    UBase aBase; 
    pragma(msg, "TEST: alias, chained types");
    alias UChain = Args[0].T.TT;
    UChain aChain;
    pragma(msg, "TEST: alias, chained packs");
    alias UChainPack = Args[1+1].FArgs[0];
    UChainPack aChainPack;
    pragma(msg, "TEST: alias, expr");
    alias uExpr = Args[1].i;
    int aExpr = uExpr;
    pragma(msg, "TEST: alias, Nested + index eval");
    alias UNested = Args[Args[0].i2].T;
    UNested aNested;
}

struct B {
    struct T {
        void f() {
            writeln("B.T.f");
        }
        struct TT {
            void f() {
                writeln("B.T.TT.f");
            }
        }
    }
    enum i = 6;
    enum i2 = 0;
    void g() {
        writeln("B.g");
    }
}

struct C(Args...) {
    alias FArgs = Args;
}

alias Z = A!(B,B,C!(B,B));

void main() {
  Z z;
  z.mBase.f();       // B.T.f
  z.mChain.f();      // B.T.TT.f
  z.mChainPack.g();  // B.g
  writeln(z.mExpr);  // 6 
  z.mNested.f();     // B.T.f

  z.aBase.f();       // B.T.f
  z.aChain.f();      // B.T.TT.f
  z.aChainPack.g();  // B.g
  writeln(z.aExpr);  // 6 
  z.aNested.f();     // B.T.f
}

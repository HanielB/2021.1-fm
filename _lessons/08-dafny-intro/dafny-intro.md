---
layout: page
title: Dafny Introduction
---

# Dafny Introduction
{: .no_toc .mb-2 }

- TOC
{:toc}

## Readings

- Sections 1-5 of [[Koen12]({{ site.baseurl }}{% link _lessons/08-dafny-intro/Koen12.pdf %})], an introduction to the Dafny language
  - Also available as an [online tutorial](http://rise4fun.com/Dafny/tutorial/guide)
- [Examples]({{ site.baseurl }}{% link _lessons/08-dafny-intro/examples.tar.gz %})
- [Dafny Reference Manual](https://dafny-lang.github.io/dafny/DafnyRef/DafnyRef)

### Recommended readings

- [[Wing95]({{ site.baseurl }}{% link _lessons/08-dafny-intro/Wing95.pdf %})], which provides several hints to specifiers.

## Topics

- Specifying and verifying programs in high-level programming languages.
- Introduction to Dafny. Main features.
- Method contracts in Dafny.
- Specifying pre and post-conditions.
- Compositional verification of methods through the use of contracts.
- Abstraction of while loops by loop invariants.

## Example: Absolute value

``` c++
method abs (x : int) returns (y : int)
    ensures 0 <= x ==> x == y
    ensures 0 > x ==> -x == y
{
    if x < 0
    {
        return -x;
    }
    else
    {
        return x;
    }
}

method Main()
{
    var x := -3;
    var n := abs(x);
    assert n >= 0;
    print "Absolute value of ", x, ": ", n, "\n";
}
```

## Example: Fibonacci

``` c++
function fib (n:nat):nat
    decreases n
{
    if n == 0 then 0
    else if n == 1 then 1
    else fib(n - 1) + fib(n - 2)
}

method fibImp(n:nat) returns (res:nat)
    ensures res == fib(n)
{
    if n == 0 { return 0; }
    var i := 1;
    var a := 0;
    var b := 1;
    while i < n
        decreases n - i
        invariant i <= n
        invariant a == fib(i - 1)
        invariant b == fib(i)
    {
        a, b := b, a + b;
        i := i + 1;
    }
    // (i >= n ^ i <= n ^ fib(i) == b) => b == fib(n)
    return b;
}

method Main()
{
    var x := 6;
    var i := 1;
    while i <= x
    {
      var res := fibImp(i);
      print "fib(", i, ") = ", res, "\n";
      i := i + 1;
    }
}
```

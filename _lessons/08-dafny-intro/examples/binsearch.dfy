predicate isSorted(a:array<int>)
{
  true
}















// a[lo] <= a[lo+1] <= ... <= a[hi-2] <= a[hi-1]
method binSearch(a:array<int>, K:int) returns (b:bool)
{
  var lo: nat := 0 ;
  var hi: nat := a.Length ;
  while (lo < hi)
  {
    var mid: nat := (lo + hi) / 2 ;
    if (a[mid] < K) {
      lo := mid + 1 ;
    } else if (a[mid] > K) {
      hi := mid ;
    } else {
      return true ;
    }
  }
  return false ;
}

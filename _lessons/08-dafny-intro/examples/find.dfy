method Find(a: array?<int>, key: int) returns (index: int)
requires a != null;
{
   index := 0;
   while (index < a.Length)
   decreases a.Length - index
   {
      if (a[index] == key) { return; }
      index := index + 1;
   }
   index := -1;
}

using System;
using System.Collections.Generic;

namespace lingo
{
    public static partial class Extensions
    {
        public static void ForEach<T>(this IEnumerable<T> enumerable, Action<T> forEachDelegate)
        {
            foreach (var e in enumerable)
                forEachDelegate(e);
        }
    }
}

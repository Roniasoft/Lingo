using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace lingo.filer
{
    static class Extensions
    {
        public static TValue GetOrNull<TKey, TValue>(this Dictionary<TKey, TValue> dict, TKey key)
            where TValue : class
        {
            if (dict.ContainsKey(key))
                return dict[key];
            return null;
        }

        public static void ForEach<T>(this IEnumerable<T> enumerable, Action<T> forEachDelegate)
        {
            foreach (var e in enumerable)
                forEachDelegate(e);
        }

        public static IEnumerable<XElement> IterChildNodes(this XElement root)
        {
            var node = root.FirstNode;
            while (true)
            {
                if (node == null)
                    break;

                try
                {
                    if (node.NodeType != System.Xml.XmlNodeType.Element)
                        continue;

                    yield return (XElement)node;
                }
                finally
                {
                    node = node.NextNode;
                }
            }
        }

        public static bool SetIf<T>(this object control, ref T variable, T value)
        {
            if (Equals(variable, value))
                return false;

            variable = value;
            return true;
        }

        public static void SetAndDoIf<T>(this object control,
            ref T variable, T value, Action doActionIfSet)
        {
            if (control.SetIf(ref variable, value))
                doActionIfSet();
        }
    }
}

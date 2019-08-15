using System.Collections.Generic;
using System.Xml.Linq;

namespace lingo.sync
{
    static class XElementExtensions
    {
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
    }
}

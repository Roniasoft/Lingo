using System.Linq;
using System.Xml.Linq;

namespace lingo.filer
{
    /// <summary>
    /// Formerly AppString from previous lingo implementation. This class is a wrapper around the XML element.
    /// </summary>
    sealed class XmlPhraseEntry
    {
        public XElement Element { get; }
        public bool IsValid { get; }

        // Phrase Key / Name / ID
        public string Name => Element?.Attribute("name").Value;

        // Translation value
        public string Value
        {
            get => _valueElt?.Value;
            set => _valueElt.Value = value;
        }
        readonly XElement _valueElt;

        // Description
        public string Comment => _commentElt?.Value;
        readonly XElement _commentElt;

        // Base language phrase
        public string EnglishValue
        {
            get => _englishValueElt?.Value;
            set
            {
                if (_englishValueElt == null)
                    Element.AddFirst(_englishValueElt = new XComment(value));
                else
                    _englishValueElt.Value = value;
            }
        }
        XComment _englishValueElt;

        // IsDirty
        public bool IsDirty
        {
            get => Element?.Attribute("dirty")?.Value == "1";
            set
            {
                if (value == IsDirty)
                    return;

                if (value)
                    Element.Add(new XAttribute("dirty", "1"));
                else
                    Element.Attribute("dirty")?.Remove();
            }
        }

        public XmlPhraseEntry(XElement element)
        {
            Element = element;
            _valueElt = element.Nodes()
                .OfType<XElement>()
                .Where(n => n.Name == "value")
                .FirstOrDefault();
            _commentElt = element.Nodes()
                .OfType<XElement>()
                .Where(n => n.Name == "comment")
                .FirstOrDefault();
            _englishValueElt = element.Nodes()
                .OfType<XComment>()
                .FirstOrDefault();
            IsValid = Element != null && _valueElt != null;

            // If the english value is null, check for a comment node
            if (_englishValueElt == null)
            {
                var comment = element.Nodes()
                    .OfType<XComment>()
                    .FirstOrDefault();
                if (comment != null)
                {
                    EnglishValue = comment.Value;
                    comment.Remove();
                }
            }
        }

        public bool HasEnglishValue => _englishValueElt != null;
        public override string ToString() => Name;
    }
}

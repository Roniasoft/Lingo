using System.Linq;
using System.Xml.Linq;

namespace lingo.sync
{
    public sealed class AppString
    {
        readonly XElement _valueElt;
        readonly XElement _commentElt;
        XComment _englishValueElt;

        public XElement Element { get; }
        public string Name => Element?.Attribute("name").Value ?? string.Empty;
        public string Value
        {
            get => _valueElt?.Value ?? string.Empty;
            set => _valueElt.Value = value;
        }
        public string Comment => _commentElt?.Value ?? string.Empty;
        public string EnglishValue
        {
            get => _englishValueElt?.Value ?? string.Empty;
            set
            {
                if (_englishValueElt == null)
                    Element.AddFirst(_englishValueElt = new XComment(value));
                else
                    _englishValueElt.Value = value;
            }
        }

        public readonly bool IsValid;
        public bool HasEnglishValue => _englishValueElt != null;

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

        public AppString(XElement element)
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

        public override string ToString() => Name;

        public static AppString Create(AppString appString)
        {
            var dataElt = new XElement("data");
            dataElt.Add(new XAttribute("name", appString.Name));
            var spaceAttr = new XAttribute(
                XName.Get("space", "xml"),
                "preserve");
            dataElt.Add(spaceAttr);
            if (appString.HasEnglishValue)
                dataElt.AddFirst(
                    new XComment(appString.EnglishValue));
            dataElt.Add(new XElement("value", appString.Value));

            // Add the comment element if appropriate...
            if (string.IsNullOrWhiteSpace(appString.Comment) == false)
                dataElt.Add(new XElement("comment", appString.Comment));

            return new AppString(dataElt) { IsDirty = true };
        }
    }
}

using System.Linq;
using System.Xml.Linq;

namespace lingo
{
    sealed class AppString
    {
        readonly XElement _element;
        readonly XElement _valueElt;
        readonly XElement _commentElt;
        XComment _englishValueElt;

        public XElement Element => _element;
        public string Name => _element?.Attribute("name").Value ?? string.Empty;
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
                    _element.AddFirst(_englishValueElt = new XComment(value));
                else
                    _englishValueElt.Value = value;
            }
        }

        public readonly bool IsValid;
        public bool HasEnglishValue => _englishValueElt != null;

        public bool IsDirty
        {
            get => _element?.Attribute("dirty")?.Value == "1";
            set
            {
                if (value == IsDirty)
                    return;

                if (value)
                    _element.Add(new XAttribute("dirty", "1"));
                else
                    _element.Attribute("dirty")?.Remove();
            }
        }

        public AppString(XElement element)
        {
            _element = element;
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
            IsValid = _element != null && _valueElt != null;

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

            //_fix();
        }

        public override string ToString() => Name;

        void _fix()
        {
            // Remove the dirty attr
            //_element.Attribute("dirty")?.Remove();

            var englishValueElt = _element.Nodes()
                .OfType<XElement>()
                .Where(e => e.Name == "english")
                .FirstOrDefault();
            if (englishValueElt != null)
            {
                EnglishValue = englishValueElt.Value;
                englishValueElt.Remove();
            }
            var toRem = _element.Nodes().OfType<XText>().Where(e => e.Value == "\n    \n    ").ToArray();
            toRem.ForEach(e => e.Value = "\n    ");

            //if (_englishValueElt == null)
            //    _element.Add(_englishValueElt = new XElement("english", value));
            //else
            //    _englishValueElt.Value = value;
        }
    }
}

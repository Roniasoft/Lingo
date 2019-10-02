using lingo.common;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace lingo.filer
{
    /// <summary>
    /// This class wraps the XmlPhraseEntry, which is an XML File implementation of the lingo data model, and also wraps the
    /// Lingo translations. 
    /// </summary>
    class LingoPhrase : ILingoPhrase, INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void RaisePropChanged([CallerMemberName] string name = null) =>
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));

        readonly XmlPhraseEntry _xmlEntry;

        public string Key => _xmlEntry?.Name;
        public string Text => _xmlEntry?.EnglishValue;
        public string Description => _xmlEntry?.Comment;

        public string XmlTranslation
        {
            get => _xmlEntry?.Value;
            set
            {
                if (_xmlEntry.Value == value)
                    return;
                _xmlEntry.Value = value;
                RaisePropChanged();
            }
        }

        public bool IsDirty
        {
            get => _xmlEntry.IsDirty;
            set
            {
                if (_xmlEntry.IsDirty == value)
                    return;
                _xmlEntry.IsDirty = value;
                RaisePropChanged();
            }
        }

        public LingoPhrase(XmlPhraseEntry xmlEntry) => 
            _xmlEntry = xmlEntry;

        public ILingoPhraseTranslation LingoTranslation
        {
            get => string.IsNullOrWhiteSpace(XmlTranslation) ?
                null :
                new LingoPhraseTranslation(this, XmlTranslation, IsDirty);
            set
            {
                if (XmlTranslation == value.Translation &&
                    IsDirty == value.IsDirty)
                    return;

                XmlTranslation = value.Translation;
                IsDirty = value.IsDirty;
                RaisePropChanged();
            }
        }

        public bool Equals(ILingoPhrase other) => Key == other.Key;
        public override bool Equals(object obj) => obj is ILingoPhrase lp ? Equals(lp) : false;
        public override int GetHashCode() => typeof(ILingoPhrase).GetHashCode() + Key.GetHashCode();
    }
}

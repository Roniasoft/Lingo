using lingo.common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace lingo.filer
{
    class LingoGroupFile : ILingoGroup
    {
        public event EventHandler<string> DataModified;

        public string Key { get; }
        public string FriendlyName => $"{_friendlyNameBase} ({Language.Key})";
        string _friendlyNameBase { get; }
        public ILingoLanguage Language { get; }

        readonly string _filepath;
        readonly XDocument _doc;
        readonly HashSet<LingoPhrase> _phrases = new HashSet<LingoPhrase>();

        public LingoGroupFile(string filepath, string friendlyName)
        {
            if (!File.Exists(this._filepath = filepath))
                throw new ArgumentException("File at <filepath> does not exist");

            Key = Path.GetFileName(_filepath);
            _friendlyNameBase = friendlyName;

            // Parse the language from the filename
            Language = LingoLanguages.ParseLanguageFromFilename(_filepath);

            // Load the phrases from the file
            _doc = new XDocument(XDocument.Load(_filepath));
            _iterAppStrings(_doc.Root)
                .Select(xmlEntry => new LingoPhrase(xmlEntry))
                .ForEach(phrase => _phrases.Add(phrase));
                
        }

        IEnumerable<XmlPhraseEntry> _iterAppStrings(XElement root) => 
            root.IterChildNodes()
                .Where(e => e.Name == "data")
                .Select(e => new XmlPhraseEntry(e))
                .Where(e => e.IsValid);

        public bool Equals(ILingoGroup other) =>
            Key == other.Key;

        public override bool Equals(object obj) =>
            obj is ILingoGroup lg ? Equals(lg) : false;

        public override int GetHashCode() =>
            typeof(ILingoGroup).GetHashCode() + Key.GetHashCode();

        #region Interface methods

        public IEnumerable<ILingoPhrase> IterPhrases() => _phrases;

        public (bool Success, string Message) CommitPhraseTranslation(ILingoPhraseTranslation translation)
        {
            if (!_phrases.Contains(translation.BasePhrase))
                return (false, "Phrase doesn't exist in group");

            var validation = ValidatePhraseTranslation(translation);
            if (!validation.IsValid)
                return validation;

            var impl = translation.BasePhrase as LingoPhrase;
            if (impl == null)
                return (false, "Incompatible ILingoPhraseTranslation implementation");

            impl.LingoTranslation = translation;

            var message = "Translation committed";

            // Save the XML doc
            try { _doc.Save(_filepath); }
            catch (Exception e) { return (false, e.ToString()); }

            DataModified?.Invoke(this, message);
            return (true, message);
        }

        public (bool IsValid, string Message) ValidatePhraseTranslation(ILingoPhraseTranslation translation) =>
            // TODO: check for invalid characters etc
            (true, null);

        public ILingoPhraseTranslation GetTranslationFor(ILingoPhrase phrase)
        {
            var impl = phrase as LingoPhrase;
            if (impl == null)
                throw new InvalidOperationException("Incompatible ILingoPhraseTranslation implementation");
            return impl.LingoTranslation;
        }

        #endregion

        // Helpers
        public static (LingoGroupFile Group, string Error) ParseFromFile(string filepath, string friendlyName)
        {
            if (!File.Exists(filepath))
                return (null, "Filepath not found");

            try { return (new LingoGroupFile(filepath, friendlyName), null); }
            catch (Exception e) { return (null, e.ToString()); }
        }
    }
}

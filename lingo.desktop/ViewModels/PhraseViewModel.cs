using Qml.Net;
using lingo.desktop.Model;
using System;
using System.Threading.Tasks;

namespace lingo.desktop.ViewModels
{
    public sealed class PhraseViewModel
    {
        public string Key => _phrase.Key;
        public string Value => _phrase.Value;
        public string Description => _phrase.Description;
        public string Translation
        {
            get => _phrase.Translation;
            set
            {
                _phrase.Translation = value;
            }
        }

        readonly Phrase _phrase;

        internal PhraseViewModel(Phrase phrase)
        {
            _phrase = phrase;
        }
    }
}
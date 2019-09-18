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
        
        [NotifySignal]
        public string Translation
        {
            get => _phrase.Translation;
            set
            {
                _phrase.Translation = value;
            }
        }
        
        [NotifySignal]
        public bool IsOpen
        {
            get => _phrase.IsOpen;
            set
            {
                _phrase.IsOpen = value;
            }
        }
        
        [NotifySignal]
        public bool IsCompleted
        {
            get => _phrase.IsCompleted;
            set
            {
                _phrase.IsCompleted = value;
            }
        }

        
        [NotifySignal]
        public bool Highlighted
        {
            get => _phrase.Highlighted;
            set
            {
                _phrase.Highlighted = value;
            }
        }


        readonly Phrase _phrase;

        internal PhraseViewModel(Phrase phrase)
        {
            _phrase = phrase;
        }


    }
}
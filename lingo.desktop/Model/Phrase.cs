using System;

namespace lingo.desktop.Model
{
    internal sealed class Phrase
    {
        public string Key { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
        public string Translation { get; set; }
        public bool IsOpen {get; set;}
        public bool IsCompleted {get; set;}

        public bool Highlighted {get; set;}

        public Phrase()
        {
            Key = "";
            Value = "";
            Description = "";
            Translation = "";
            IsOpen = false;
            IsCompleted = false;
            Highlighted = false;
        }
    }
}
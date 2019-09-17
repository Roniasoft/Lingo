using System;

namespace lingo.desktop.Model
{
    internal sealed class Phrase
    {
        public string Key { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
        public string Translation { get; set; }

        public Phrase()
        {
            Key = "";
            Value = "";
            Description = "";
            Translation = "";
        }
    }
}
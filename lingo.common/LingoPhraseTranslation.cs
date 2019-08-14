namespace lingo.common
{
    public class LingoPhraseTranslation
    {
        public LingoPhrase BasePhrase { get; }
        public string Translation { get; set; }

        public LingoPhraseTranslation(LingoPhrase basePhrase, string translation)
        {
            BasePhrase = basePhrase;
            Translation = translation;
        }
    }
}

namespace lingo.common
{
    public class LingoPhraseTranslation : ILingoPhraseTranslation
    {
        public ILingoPhrase BasePhrase { get; }
        public string Translation { get; set; }
        public bool IsDirty { get; }

        public LingoPhraseTranslation(ILingoPhrase basePhrase, string translation, bool isDirty)
        {
            BasePhrase = basePhrase;
            Translation = translation;
            IsDirty = isDirty;
        }
    }
}

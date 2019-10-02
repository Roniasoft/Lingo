namespace lingo.common
{
    public interface ILingoPhraseTranslation
    {
        ILingoPhrase BasePhrase { get; }
        string Translation { get; set; }
        bool IsDirty { get; }
    }
}

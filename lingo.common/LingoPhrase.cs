namespace lingo.common
{
    public class LingoPhrase
    {
        public string Key { get; }
        public string Text { get; }
        public string Description { get; }

        public LingoPhrase(string key, string text, string description)
        {
            Key = key;
            Text = text;
            Description = description;
        }
    }
}

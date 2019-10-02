using System;

namespace lingo.common
{
    public interface ILingoPhrase : IEquatable<ILingoPhrase>
    {
        /// <summary>
        /// The unique key of the phrase
        /// </summary>
        string Key { get; }

        /// <summary>
        /// The base language phrase text
        /// </summary>
        string Text { get; }

        /// <summary>
        /// A description of the phrase and how it is used, to provide context to translators
        /// </summary>
        string Description { get; }
    }
}

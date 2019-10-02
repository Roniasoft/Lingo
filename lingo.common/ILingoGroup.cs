using System;
using System.Collections.Generic;

namespace lingo.common
{
    public interface ILingoGroup : IEquatable<ILingoGroup>
    {
        /// <summary>
        /// The key of the group, used to identify it uniquely, e.g. SomeFile.resx
        /// </summary>
        string Key { get; }

        /// <summary>
        /// The friendly displayname of the group
        /// </summary>
        string FriendlyName { get; }

        /// <summary>
        /// The language associated with the group of phrases
        /// </summary>
        ILingoLanguage Language { get; }

        /// <summary>
        /// Gets all available phrases for the group
        /// </summary>
        /// <returns></returns>
        IEnumerable<ILingoPhrase> IterPhrases();

        /// <summary>
        /// Checks whether the translation is valid before committing the translation (e.g. allows checks for illegal characters or other implementation specific validations)
        /// </summary>
        /// <param name="translation">the translation to validate</param>
        /// <returns>bool for true=IsValid, false=Invalid. string for status message regardless of bool, not always set</returns>
        (bool IsValid, string Message) ValidatePhraseTranslation(ILingoPhraseTranslation translation);

        /// <summary>
        /// Commits a translation for a phrase to this group. This may or may not publish changes to the server, that's an implementation decision.
        /// You can call ValidatePhraseTranslation to check if the translation is valid before committing
        /// </summary>
        /// <param name="translation">The phrase to commit a translation for</param>
        /// <returns>bool for true=success, false=error, string for status message regardless of bool</returns>
        (bool Success, string Message) CommitPhraseTranslation(ILingoPhraseTranslation translation);

        /// <summary>
        /// Gets the translation for the specified phrase.
        /// </summary>
        /// <param name="phrase">The phrase to get translation for</param>
        /// <returns>The phrase translation for this group. Returns null if none exists</returns>
        ILingoPhraseTranslation GetTranslationFor(ILingoPhrase phrase);
    }
}

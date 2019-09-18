using System.Collections.Generic;
using System.Threading.Tasks;

namespace lingo.common
{
    public interface ILingoDataService
    {
        /// <summary>
        /// Iterates the available groups. These might be filenames
        /// </summary>
        /// <returns></returns>
        IEnumerable<(string groupKey, string groupName)> IterAvailableGroups();

        /// <summary>
        /// Fetches new base-phrases from server, merges any updates, dirties any existing phrases, and pushes new local translations to the server.
        /// If any base phrases have changed since before then those translations will be marked as dirty.
        /// After merging, translations get published to server.
        /// </summary>
        Task<(bool Success, string Message)> SyncDataAsync();

        /// <summary>
        /// Gets all base-language phrases
        /// </summary>
        /// <param name="groupKey">the group key, e.g. perhaps representing the filename it comes from</param>
        /// <returns></returns>
        IEnumerable<LingoPhrase> IterAllDefaultPhrases(string groupKey = null);


        /// <summary>
        /// Gets all base-language phrases without a translation for a given language key L.
        /// </summary>
        /// <param name="langKey">the key for language L</param>
        /// <param name="groupKey">the group key, e.g. perhaps representing the filename it comes from</param>
        IEnumerable<LingoPhrase> IterUntranslatedPhrases(string langKey, string groupKey = null);


        /// <summary>
        /// Gets all base-language phrases having a translation for a given language key L.
        /// </summary>
        /// <param name="langKey">the key for language L</param>
        /// <param name="groupKey">the group key, e.g. perhaps representing the filename it comes from</param>
        Dictionary<LingoPhrase, LingoPhraseTranslation> IterTranslatedPhrases(string langKey, string groupKey = null);

        /// <summary>
        /// Gets all dirty translations and their phrases for a given language key L.
        /// Dirty translations are ones where the base-language text no longer matches the local phrase text. i.e. text has been updated at the server, so the translation needs to be checked/re-done
        /// </summary>
        /// <param name="langKey">the key for language L</param>
        /// <param name="groupKey">the group key, e.g. perhaps representing the filename it comes from</param>
        IEnumerable<(LingoPhrase Phrase, LingoPhraseTranslation Translation)> IterDirtyPhrases(string langKey, string groupKey = null);

        /// <summary>
        /// Writes a translation to the data layer for a given language key L. This may or may not publish changes to the server, that's an implementation decision
        /// </summary>
        /// <param name="phraseBase">The phrase to commit a translation for</param>
        /// <param name="translation">The translated text</param>
        /// <param name="langKey">The translated language key L</param>
        /// <param name="groupKey">the group key, e.g. perhaps representing the filename it comes from</param>
        /// <returns>bool for true=success, false=error, string for status message regardless of bool</returns>
        (bool Success, string Message) SetPhraseTranslation(LingoPhraseTranslation translation, string langKey);
    }
}

using lingo.common;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace lingo.rsync.mock
{
    public class LingoDataServiceRsyncMock : ILingoDataServiceMock
    {
        Dictionary<LingoPhrase, string> _phraseGroups = new Dictionary<LingoPhrase, string>();
        Dictionary<string, List<LingoPhrase>> _groupPhrases = new Dictionary<string, List<LingoPhrase>>();
        Dictionary<string, Dictionary<LingoPhrase, LingoPhraseTranslation>> _translations = new Dictionary<string, Dictionary<LingoPhrase, LingoPhraseTranslation>>();
        Dictionary<string, Dictionary<LingoPhrase, LingoPhraseTranslation>> _dirtyTranslations = new Dictionary<string, Dictionary<LingoPhrase, LingoPhraseTranslation>>();
        public bool IsOnline { get; set; }
        readonly int _publishPause;

        public LingoDataServiceRsyncMock(bool isOnline = true, int publishPause = 3000)
        {
            IsOnline = isOnline;
            _publishPause = publishPause;

            _resetData();
        }

        void _resetData()
        {
            _phraseGroups.Clear();
            _groupPhrases.Clear();
            _translations.Clear();
            _dirtyTranslations.Clear();

            _initData();
        }

        const string ENGLISH = "en";
        const string RUSSIAN = "ru";
        const string SPANISH = "es";

        public void _initData()
        {
            var p1 = AddBasePhrase("EULA.Instructions", "Please read and accept the following End User Licence Agreement (EULA) to use this software:", "Instructions to the user when presented with the EULA when first opening the program");
            var p2 = AddBasePhrase("General.Application", "Application", "something y'know");

            var p3 = AddBasePhrase("General.ApplicationExiting", "Application Exiting...", "Title message when telling the user the application will close. This is displayed above a detailed message explaining the reasons why it is exiting, perhaps prompting the user to save or cancel");
            var p4 = AddBasePhrase("Program.StatusBar.OpenLogButton", "Open Log", "Text for the [Open Log] button in the program's bottom-right status bar");
            var p5 = AddBasePhrase("Window.Log.Button.ClearLog", "Clear Log", "Text in the [Clear Log] button in the [Message Log] window. Click this clears the log window contents.");
            AddBasePhrase("Window.Log.Button.OpenToLogFile", "Open To File", "Text in the [Open to File] button in the [Message Log] window. Clicking navigates to the file location in Windows Explorer");
            AddBasePhrase("Window.Log.Title", "Message Log", "Title of the [Message Log] window, opened by clicking the Open Log button in the bottom-right corner of the application");
            AddBasePhrase("Window.Prefs.Title", "Preferences", "Title of the [App Preferences] window, opened from the file/application menu");

            AddBasePhrase("Window.GiveFeedback.IncludeSession", "Include Session File", "Checkbox asking the user whether or not to include the current session/design file in the feedback report.", GROUP_HINTS);
            AddBasePhrase("Window.GiveFeedback.Instructions", "Please write your feedback below", "Instruction text for the user in the [Give Feedback] window. This can be found in the [Message Log]", GROUP_HINTS);
            AddBasePhrase("Window.GiveFeedback.SuccessMessage", "Feedback sent - Thanks!", "Success message displayed after the user sends feedback, via the GiveFeedback tool found in the bottom-right corner from the [Message Log]", GROUP_HINTS);

            // Russian - completed translations
            _addTranslation(_translate(p1, "%%%%Please read and accept the following End User Licence Agreement (EULA) to use this software:%%%%"), RUSSIAN);
            _addTranslation(_translate(p2, "%%%%Application%%%%"), RUSSIAN);

            // Russian - dirty translations
            _addDirtyTranslation(_translate(p3, "%%%%Application Exiting...%%%%"), RUSSIAN);
            _addDirtyTranslation(_translate(p4, "%%%%Open Log%%%%"), RUSSIAN);
            _addDirtyTranslation(_translate(p5, "%%%%Clear Log%%%%"), RUSSIAN);

            // Spanish - completed translations
            _addTranslation(_translate(p1, "%%%%Please read and accept the following End User Licence Agreement (EULA) to use this software:%%%%"), SPANISH);
            _addTranslation(_translate(p2, "%%%%Application%%%%"), SPANISH);

            // Spanish - dirty translations
            _addDirtyTranslation(_translate(p3, "%%%%Application Exiting...%%%%"), SPANISH);
            _addDirtyTranslation(_translate(p4, "%%%%Open Log%%%%"), SPANISH);
            _addDirtyTranslation(_translate(p5, "%%%%Clear Log%%%%"), SPANISH);
        }

        public const string GROUP_DISPLAY_TEXT = "DisplayText";
        public const string GROUP_HINTS = "Hints";

        LingoPhraseTranslation _translate(LingoPhrase phrase, string text) => 
            new LingoPhraseTranslation(phrase, text);

        public LingoPhrase AddBasePhrase(string key, string value, string description, string group = GROUP_DISPLAY_TEXT)
        {
            var phrase = new LingoPhrase(key, value, description);
            _phraseGroups[phrase] = group;
            if (!_groupPhrases.ContainsKey(group))
                _groupPhrases[group] = new List<LingoPhrase>();
            _groupPhrases[group].Add(phrase);
            return phrase;
        }

        void _addTranslation(LingoPhraseTranslation translation, string translatedLangKey)
        {
            if (!_translations.ContainsKey(translatedLangKey))
                _translations[translatedLangKey] = new Dictionary<LingoPhrase, LingoPhraseTranslation>();
            _translations[translatedLangKey][translation.BasePhrase] = translation;

            if (_dirtyTranslations.ContainsKey(translatedLangKey) &&
                _dirtyTranslations[translatedLangKey].ContainsKey(translation.BasePhrase))
                _dirtyTranslations[translatedLangKey].Remove(translation.BasePhrase);
        }

        void _addDirtyTranslation(LingoPhraseTranslation translation, string translatedLangKey)
        {
            _addTranslation(translation, translatedLangKey);
            if (!_dirtyTranslations.ContainsKey(translatedLangKey))
                _dirtyTranslations[translatedLangKey] = new Dictionary<LingoPhrase, LingoPhraseTranslation>();
            _dirtyTranslations[translatedLangKey][translation.BasePhrase] = translation;
        }

        public (bool Success, string Message) SetPhraseTranslation(LingoPhraseTranslation translation, string langKey)
        {
            _addTranslation(translation, langKey);
            var msg = IsOnline ?
                $"Online: Translated Phrase [{translation.BasePhrase.Key}] published to server." :
                $"Offline: Translated Phrase [{translation.BasePhrase.Key}] committed to database for publishing later.";

            // Example: write data to server

            // Example error handling
            var errors = false;
            var errorMsg = "An error occurred";
            if (errors)
                return (false, errorMsg);

            return (true, msg);
        }

        public IEnumerable<LingoPhrase> IterAllDefaultPhrases(string groupKey = null)
        {
            if (string.IsNullOrWhiteSpace(groupKey))
                return _phraseGroups.Keys;
            if (_groupPhrases.ContainsKey(groupKey))
                return _groupPhrases[groupKey];
            return new LingoPhrase[0];
        }

        public IEnumerable<(LingoPhrase Phrase, LingoPhraseTranslation Translation)> IterDirtyPhrases(string langKey, string groupKey = null)
        {
            if (!_translations.ContainsKey(langKey))
                return new (LingoPhrase, LingoPhraseTranslation)[0];

            if (string.IsNullOrWhiteSpace(groupKey))
                return _dirtyTranslations[langKey]
                    .Select(p => (p.Key, p.Value));

            if (_groupPhrases.ContainsKey(groupKey))
                return _dirtyTranslations[langKey]
                    .Where(p => _phraseGroups[p.Key] == groupKey)
                    .Select(p => (p.Key, p.Value));

            else return new (LingoPhrase Phrase, LingoPhraseTranslation Translation)[0];
        }

        public IEnumerable<LingoPhrase> IterUntranslatedPhrases(string langKey, string groupKey = null)
        {
            if (!_translations.ContainsKey(langKey))
                return new LingoPhrase[0];

            IEnumerable<LingoPhrase> phrases = null;
            if (string.IsNullOrWhiteSpace(groupKey))
                phrases = _phraseGroups.Keys;
            else if (_groupPhrases.ContainsKey(groupKey))
                phrases = _groupPhrases[groupKey];
            else
                return new LingoPhrase[0];

            var translations = _translations[langKey];
            return (from p in phrases
                    join t in translations on p equals t.Key into pts
                    from pt in pts.DefaultIfEmpty()
                    where pt.Value == null
                    select p)
                .ToList();
        }

        public void ResetMockData() => _resetData();

        public async Task<(bool, string)> SyncDataAsync()
        {
            await Task.Delay(_publishPause).ConfigureAwait(false);
            return IsOnline ?
                (true, "Publish Success: Translation Data successfully published to server") :
                (false, "Publish Fail: No connection available, data will be published later");
        }

        public IEnumerable<(string groupKey, string groupName)> IterAvailableGroups()
        {
            Dictionary<string, string> groups =  new Dictionary<string, string>();
            groups.Add("en", "english");    // I don't know yet what exactly are the groupKey and groupName.
            groups.Add("ru", "russian");    //  So, I just write these as a simple one. Easily change these then I'll adjust my codes
            groups.Add("es", "spanish");
            return groups.Select(p => (p.Key, p.Value));
        }
    }
}

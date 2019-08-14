using lingo.common;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using System.Threading.Tasks;

namespace lingo.rsync.mock.test
{
    [TestClass]
    public class MockServiceTests
    {
        LingoPhraseTranslation _translate(LingoPhrase phrase, string translation) => 
            new LingoPhraseTranslation(phrase, translation);

        [TestMethod]
        public async Task TestMockService()
        {
            var impl = new LingoDataServiceRsyncMock(true, 0);
            ILingoDataServiceMock mock = impl;
            ILingoDataService lingoSvc = mock;

            // Check phrases
            var expected = 11;
            var phrases = lingoSvc.IterAllDefaultPhrases();
            Assert.AreEqual(expected, phrases.Count());

            mock.AddBasePhrase("SomethingNew", "Some TexT", "Texty Text");
            expected = 12;
            phrases = lingoSvc.IterAllDefaultPhrases();
            Assert.AreEqual(expected, phrases.Count());

            // Check untranslated
            var lang = "ru";
            expected = 7;
            var untranslated = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, untranslated.Count());

            lang = "es";
            untranslated = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, untranslated.Count());

            var phrase = phrases.Last();

            // Commit a translation and ensure it doesn't appear in the fetch list
            lang = "ru";
            expected = 6;
            lingoSvc.SetPhraseTranslation(_translate(phrase, "%%%Translated Text%%%%"), lang);
            untranslated = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, untranslated.Count());
            Assert.IsFalse(untranslated.Contains(phrase));

            // Check spanish not touched
            lang = "es";
            expected = 7;
            untranslated = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, untranslated.Count());
            Assert.IsTrue(untranslated.Contains(phrase));

            // Commit for spanish and ensure it doesn't appear in untranslated list
            expected = 6;
            lingoSvc.SetPhraseTranslation(_translate(phrase, "%%%Translated Text%%%%"), lang);
            untranslated = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, untranslated.Count());
            Assert.IsFalse(untranslated.Contains(phrase));

            // Check dirtied
            lang = "ru";
            expected = 3;
            var dirtied = lingoSvc.IterDirtyPhrases(lang);
            Assert.AreEqual(expected, dirtied.Count());

            // Add translation, ensure it no longer appears in dirtied
            expected = 2;
            var translation = dirtied.First();
            lingoSvc.SetPhraseTranslation(translation.Translation, lang);
            dirtied = lingoSvc.IterDirtyPhrases(lang);
            Assert.AreEqual(expected, dirtied.Count());
            Assert.IsFalse(dirtied.Any(p => p.Phrase == translation.Phrase));

            // Ensure spanish still contains the dirty phrase
            lang = "es";
            expected = 3;
            dirtied = lingoSvc.IterDirtyPhrases(lang);
            Assert.AreEqual(expected, dirtied.Count());
            Assert.IsTrue(dirtied.Any(p => p.Phrase == translation.Phrase));

            // Ensure publish succeeds when online
            mock.IsOnline = true;
            var result = await lingoSvc.SyncDataAsync();
            Assert.IsTrue(result.Success);

            // Ensure publish fails when offline
            mock.IsOnline = false;
            result = await lingoSvc.SyncDataAsync();
            Assert.IsFalse(result.Success);

            // Check IterAllDefaultPhrases groups filter correctly
            expected = 12;
            var results = lingoSvc.IterAllDefaultPhrases();
            Assert.AreEqual(expected, results.Count());

            expected = 9;
            results = lingoSvc.IterAllDefaultPhrases(LingoDataServiceRsyncMock.GROUP_DISPLAY_TEXT);
            Assert.AreEqual(expected, results.Count());

            expected = 3;
            results = lingoSvc.IterAllDefaultPhrases(LingoDataServiceRsyncMock.GROUP_HINTS);
            Assert.AreEqual(expected, results.Count());

            // Check IterUntranslatedPhrases groups filter correctly
            lang = "ru";
            expected = 6;
            results = lingoSvc.IterUntranslatedPhrases(lang);
            Assert.AreEqual(expected, results.Count());

            expected = 3;
            results = lingoSvc.IterUntranslatedPhrases(lang, LingoDataServiceRsyncMock.GROUP_DISPLAY_TEXT);
            Assert.AreEqual(expected, results.Count());

            expected = 3;
            results = lingoSvc.IterUntranslatedPhrases(lang, LingoDataServiceRsyncMock.GROUP_HINTS);
            Assert.AreEqual(expected, results.Count());

            // Check IterDirtyPhrases groups filter correctly
            expected = 2;
            dirtied = lingoSvc.IterDirtyPhrases(lang);
            Assert.AreEqual(expected, dirtied.Count());

            expected = 2;
            dirtied = lingoSvc.IterDirtyPhrases(lang, LingoDataServiceRsyncMock.GROUP_DISPLAY_TEXT);
            Assert.AreEqual(expected, dirtied.Count());

            expected = 0;
            dirtied = lingoSvc.IterDirtyPhrases(lang, LingoDataServiceRsyncMock.GROUP_HINTS);
            Assert.AreEqual(expected, dirtied.Count());

            expected = 1;
            dirtied = lingoSvc.IterDirtyPhrases(lang, LingoDataServiceRsyncMock.GROUP_DISPLAY_TEXT);
            translation = dirtied.First();
            lingoSvc.SetPhraseTranslation(translation.Translation, lang);
            dirtied = lingoSvc.IterDirtyPhrases(lang, LingoDataServiceRsyncMock.GROUP_DISPLAY_TEXT);
            Assert.AreEqual(expected, dirtied.Count());
            Assert.IsFalse(dirtied.Any(p => p.Phrase == translation.Phrase));

            // Check the other group wasn't affected
            expected = 0;
            dirtied = lingoSvc.IterDirtyPhrases(lang, LingoDataServiceRsyncMock.GROUP_HINTS);
            Assert.AreEqual(expected, dirtied.Count());
        }
    }
}

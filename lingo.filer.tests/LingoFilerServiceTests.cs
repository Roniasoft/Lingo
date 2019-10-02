using lingo.common;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace lingo.filer.tests
{
    [TestClass]
    public class LingoFilerServiceTests
    {
        [TestMethod]
        public async Task ServiceBehaves()
        {
            var service = new LingoFilerService(new ExampleConfig());
            var i = service as ILingoDataService;

            const string EN = "en";
            const string ES = "es";
            const string RU = "ru";

            Assert.AreEqual(LingoLanguages.English, service.BaseLanguage);

            var groups = service.IterAvailableGroups().ToArray();
            Assert.AreEqual(4, groups.Count());

            bool syncDataRequested = false;
            service.SyncDataRequested += (o, e) => syncDataRequested = true;
            await service.SyncDataAsync();
            Assert.IsTrue(syncDataRequested);

            var groupDisplayNamesSpanish = groups[0];
            var groupDisplayNamesRussian = groups[1];
            var groupDescriptionsSpanish = groups[2];
            var groupDescriptionsRussian = groups[3];

            Assert.AreEqual("DisplayNames.es.resx", groupDisplayNamesSpanish.Key);
            Assert.AreEqual("DisplayNames.ru.resx", groupDisplayNamesRussian.Key);
            Assert.AreEqual("Descriptions.es.resx", groupDescriptionsSpanish.Key);
            Assert.AreEqual("Descriptions.ru.resx", groupDescriptionsRussian.Key);

            Assert.AreEqual(LingoLanguages.Spanish, groupDisplayNamesSpanish.Language);
            Assert.AreEqual(LingoLanguages.Russian, groupDisplayNamesRussian.Language);
            Assert.AreEqual(LingoLanguages.Spanish, groupDescriptionsSpanish.Language);
            Assert.AreEqual(LingoLanguages.Russian, groupDescriptionsRussian.Language);

            const string DISPLAY_NAMES_FRIENDLY = "Display Names";
            const string DESCRIPTIONS_FRIENDLY = "Descriptions";
            Assert.AreEqual($"{DISPLAY_NAMES_FRIENDLY} ({LingoLanguages.Spanish.Key})", groupDisplayNamesSpanish.FriendlyName);
            Assert.AreEqual($"{DISPLAY_NAMES_FRIENDLY} ({LingoLanguages.Russian.Key})", groupDisplayNamesRussian.FriendlyName);
            Assert.AreEqual($"{DESCRIPTIONS_FRIENDLY} ({LingoLanguages.Spanish.Key})", groupDescriptionsSpanish.FriendlyName);
            Assert.AreEqual($"{DESCRIPTIONS_FRIENDLY} ({LingoLanguages.Russian.Key})", groupDescriptionsRussian.FriendlyName);

            IEnumerable<ILingoPhrase> _getUntranslated(ILingoGroup g) =>
                g.IterPhrases()
                    .Where(p => g.GetTranslationFor(p) == null)
                    .ToArray();

            IEnumerable<ILingoPhraseTranslation> _getDirtyTranslations(ILingoGroup g) =>
                g.IterPhrases()
                    .Select(p => g.GetTranslationFor(p))
                    .Where(t => t != null)
                    .Where(t => t.IsDirty)
                    .ToArray();

            void _translatePhrase(ILingoGroup g, ILingoPhrase phrase) =>
                g.CommitPhraseTranslation(new LingoPhraseTranslation(phrase, $"%%{phrase.Text}%%", false));

            // Display Names Spanish
            var group = groupDisplayNamesSpanish;
            var expectedTotal = 412;
            var expectedUntranslated = 0;
            var expectedDirty = 1;
            var actualAll = group.IterPhrases();
            var actualUntranslated = _getUntranslated(group);
            var actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(expectedTotal, actualAll.Count());
            Assert.AreEqual(expectedUntranslated, actualUntranslated.Count());
            Assert.AreEqual(expectedDirty, actualDirty.Count());

            actualUntranslated.ForEach(p => _translatePhrase(group, p));
            actualUntranslated = _getUntranslated(group);
            Assert.AreEqual(0, actualUntranslated.Count());

            actualDirty.ForEach(p => _translatePhrase(group, p.BasePhrase));
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(0, actualDirty.Count());

            // Display Names Russian
            group = groupDisplayNamesRussian;
            expectedTotal = 442;
            expectedUntranslated = 0;
            expectedDirty = 78;
            actualAll = group.IterPhrases();
            actualUntranslated = _getUntranslated(group);
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(expectedTotal, actualAll.Count());
            Assert.AreEqual(expectedUntranslated, actualUntranslated.Count());
            Assert.AreEqual(expectedDirty, actualDirty.Count());

            actualUntranslated.ForEach(p => _translatePhrase(group, p));
            actualUntranslated = _getUntranslated(group);
            Assert.AreEqual(0, actualUntranslated.Count());

            actualDirty.ForEach(p => _translatePhrase(group, p.BasePhrase));
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(0, actualDirty.Count());

            // Descriptions Spanish
            group = groupDescriptionsSpanish;
            expectedTotal = 462;
            expectedUntranslated = 201;
            expectedDirty = 0;
            actualAll = group.IterPhrases();
            actualUntranslated = _getUntranslated(group);
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(expectedTotal, actualAll.Count());
            Assert.AreEqual(expectedUntranslated, actualUntranslated.Count());
            Assert.AreEqual(expectedDirty, actualDirty.Count());

            actualUntranslated.ForEach(p => _translatePhrase(group, p));
            actualUntranslated = _getUntranslated(group);
            Assert.AreEqual(0, actualUntranslated.Count());

            actualDirty.ForEach(p => _translatePhrase(group, p.BasePhrase));
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(0, actualDirty.Count());

            // Descriptions Russian
            group = groupDescriptionsRussian;
            expectedTotal = 462;
            expectedUntranslated = 206;
            expectedDirty = 43;
            actualAll = group.IterPhrases();
            actualUntranslated = _getUntranslated(group);
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(expectedTotal, actualAll.Count());
            Assert.AreEqual(expectedUntranslated, actualUntranslated.Count());
            Assert.AreEqual(expectedDirty, actualDirty.Count());

            actualUntranslated.ForEach(p => _translatePhrase(group, p));
            actualUntranslated = _getUntranslated(group);
            Assert.AreEqual(0, actualUntranslated.Count());

            actualDirty.ForEach(p => _translatePhrase(group, p.BasePhrase));
            actualDirty = _getDirtyTranslations(group);
            Assert.AreEqual(0, actualDirty.Count());
        }
    }
}

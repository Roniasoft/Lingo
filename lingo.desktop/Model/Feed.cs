using lingo.rsync.mock;
using lingo.common;
using System.Collections.Generic;
using System.Linq;

namespace lingo.desktop.Model
{
    public class Feed
    {
        public IEnumerable<Project> Projects => _projects;
        public LingoDataServiceRsyncMock DataServiceMock;

        readonly List<Project> _projects;
        public Feed()
        {
            _projects = new List<Project>();
            DataServiceMock = new LingoDataServiceRsyncMock(true, 0);
            IEnumerable<(string langKey, string groupName)> availableGroups;
            availableGroups = DataServiceMock.IterAvailableGroups();
            int id = 0;
            foreach (var item in availableGroups)
            {
                Project groupItem = new Project(id++);
                groupItem.Id = id++;
                groupItem.Title = item.groupName;
                groupItem.LangKey = item.langKey;
                groupItem.Summary = "18 out of 25 translations completed!";
                groupItem.IsOpen = false;

                Dictionary<LingoPhrase, LingoPhraseTranslation> translatedPhrases = DataServiceMock.IterTranslatedPhrases(item.langKey);
                List<LingoPhrase> phrases = DataServiceMock.IterAllDefaultPhrases().ToList();

                foreach (LingoPhrase phrase in phrases)
                {
                    Phrase rawPhrase = new Phrase();
                    rawPhrase.Key = phrase.Key;
                    rawPhrase.Value = phrase.Text;
                    rawPhrase.Description = phrase.Description;

                    // check if the phrase have a translation then add it
                    if (translatedPhrases.ContainsKey(phrase))
                    {
                        rawPhrase.Translation = translatedPhrases[phrase].Translation;
                    }

                    groupItem.Phrases.Add(new ViewModels.PhraseViewModel(rawPhrase));
                }
                
                _projects.Add(groupItem);

            }
        }
    }
}

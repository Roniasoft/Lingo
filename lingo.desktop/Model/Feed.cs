using lingo.common;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using lingo.filer;

namespace lingo.desktop.Model
{
    public class Feed
    {
        public IEnumerable<Project> Projects => _projects;
        public LingoFilerService DataServiceMock;

        readonly List<Project> _projects;
        public Feed()
        {
            _projects = new List<Project>();
            DataServiceMock = new LingoFilerService(new LingoFilerConfig());
            var service = DataServiceMock as ILingoDataService;

            var groups = service.IterAvailableGroups().ToArray();
            int id = 0;
            foreach (var item in groups)
            {
                Project groupItem = new Project(id++);
                groupItem.Id = id++;
                groupItem.LangKey = item.Key;
                groupItem.Title = item.FriendlyName;
                groupItem.Summary = item.Language.Name;
                groupItem.IsOpen = false;

                var phrases = item.IterPhrases();

                foreach (ILingoPhrase phrase in phrases)
                {
                    Phrase rawPhrase = new Phrase();
                    rawPhrase.Key = phrase.Key;
                    rawPhrase.Value = phrase.Text;
                    rawPhrase.Description = phrase.Description;

                    ILingoPhraseTranslation phraseTranslation = item.GetTranslationFor(phrase);
                    if (phraseTranslation != null) {
                        rawPhrase.Translation =  phraseTranslation.Translation;
                    }

                    groupItem.Phrases.Add(new ViewModels.PhraseViewModel(rawPhrase));
                }
                
                _projects.Add(groupItem);

            }
        }
    }
}

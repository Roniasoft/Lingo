using lingo.rsync.mock;
using System.Collections.Generic;
using System.Linq;
using lingo.common;

namespace lingo.desktop.Model
{
    internal sealed class Feed
    {
        public IEnumerable<Project> Projects => _projects;

        readonly List<Project> _projects;
        public Feed()
        {
            _projects = new List<Project>();
            var mock = new LingoDataServiceRsyncMock(true, 0);
            IEnumerable<(string groupKey, string groupName)> availableGroups;
            availableGroups = mock.IterAvailableGroups();
            int id = 0;
            foreach (var item in availableGroups)
            {
                Project groupItem = new Project(id++);
                groupItem.Id = id++;
                groupItem.Title = item.groupName;
                groupItem.Summary = item.groupName;
                groupItem.IsOpen = false;


                List<LingoPhrase> phrases = mock.IterAllDefaultPhrases().ToList();
                foreach (LingoPhrase phrase in phrases)
                {
                    Phrase rawPhrase = new Phrase();
                    rawPhrase.Key = phrase.Key;
                    rawPhrase.Value = phrase.Text;
                    rawPhrase.Description = phrase.Description;
                    groupItem.Phrases.Add(new ViewModels.PhraseViewModel(rawPhrase));
                }
                
                _projects.Add(groupItem);

            }
        }
    }
}

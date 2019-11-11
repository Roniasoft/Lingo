using lingo.common;
using lingo.desktop.Model;
using lingo.desktop.ViewModels;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Threading.Tasks;
using lingo.filer;
using Qml.Net;

namespace lingo.desktop
{
    public class NetAppContext
    {
        private readonly FeedViewModel feedViewModel;

        public NetAppContext()
        {
            var feed = new Feed();
            feed.reload();
            feedViewModel = new FeedViewModel(feed);
        }


        public void ReloadResources()
        {
            feedViewModel.reload();
        }

        public FeedViewModel GetFeedViewModel() => feedViewModel;
        public string LoadingError() => feedViewModel.ProjectsFeed.LoadingError;

        public void Log(int val) {
            Console.WriteLine(val);
        }


        
        /// <summary>
        ///     This method is called from QML whenever either a translation or iscompleted parameters are 
        /// changed by user. Then, we have to affect all view models. Also we need to call and update mock
        /// class objects. 
        ///     There is a drawback design and its about keeping data in two different layer. The first layer
        /// is in ILingoDataService and the second layer is here in view models (e.g. FeedViewModel.cs). So
        /// maybe we can integrate these layers into one signle layer or move the view-models into ILingoDataService.
        /// Currently, I've tried not to touch ILingoDataService.
        /// </summary>
        /// <param name="projectId">Each group has a id. (see Project.cs)</param>
        /// <param name="phraseKey">Each phrase has a key as in ILingoDataService.</param>
        /// <param name="translation">Translation updated by user.</param>
        /// <param name="isCompleted">IsCompleted updated by user.</param>
        /// <returns></returns>
        public async Task UpdatePhrase(string langKey, string phraseKey, string translation, bool isCompleted) {
            // At first we need to update the table models.
            List<ProjectViewModel> groups = feedViewModel.Projects;
            if (groups.Where(p => langKey == p.LangKey).Count() != 0)
            {
                ProjectViewModel group = groups.Where(p => langKey == p.LangKey).First();
                List<PhraseViewModel> phrases = group.Phrases;
                if (phrases.Where(p => p.Key == phraseKey).Count() != 0)
                {
                    PhraseViewModel phrase = phrases.Where(p => p.Key == phraseKey).First();
                    phrase.Translation = translation;
                    phrase.IsCompleted = isCompleted;

                    // Now we need to update Mock objects.
                    LingoFilerService dataService = feedViewModel.ProjectsFeed.DataServiceMock;
                    ILingoGroup lingoGroup = dataService.IterAvailableGroups().Where(p => langKey == p.Key).First();
                    ILingoPhrase lingoPhrase = lingoGroup.IterPhrases().Where(p => phraseKey == p.Key).First();

                    ILingoPhraseTranslation lingoTranslation = new LingoPhraseTranslation(lingoPhrase, translation, false);
                    lingoGroup.CommitPhraseTranslation(lingoTranslation);
                    var validateTranslation = lingoGroup.ValidatePhraseTranslation(lingoTranslation);

                    if (validateTranslation.IsValid) {
                        var result = await dataService.SyncDataAsync();
                    }
                }
            }
        }
    }
}

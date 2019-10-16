using lingo.common;
using lingo.desktop.Model;
using lingo.desktop.ViewModels;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Threading.Tasks;

namespace lingo.desktop
{
    public class NetAppContext
    {
        // LingoPhraseTranslation _translate(LingoPhrase phrase, string translation) => 
        //     new LingoPhraseTranslation(phrase, translation);

        private readonly FeedViewModel feedViewModel;

        public NetAppContext()
        {
            feedViewModel = new FeedViewModel(new Feed());
        }

        public FeedViewModel GetFeedViewModel() => feedViewModel;

        public void Log(string val) {
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
        // public async Task UpdatePhrase(int projectId, string phraseKey, string translation, bool isCompleted) {
        //     // At first we need to update the table models.
        //     List<ProjectViewModel> groups = feedViewModel.Projects;
        //     if (groups.Where(p => projectId == p.ProjectId).Count() != 0)
        //     {
        //         ProjectViewModel group = groups.Where(p => projectId == p.ProjectId).First();
        //         string langKey = group.LangKey;
        //         List<PhraseViewModel> phrases = group.Phrases;
        //         if (phrases.Where(p => p.Key == phraseKey).Count() != 0)
        //         {
        //             PhraseViewModel phrase = phrases.Where(p => p.Key == phraseKey).First();
        //             phrase.Translation = translation;
        //             phrase.IsCompleted = isCompleted;

        //             // Now we need to update Mock objects.
        //             LingoDataServiceRsyncMock dataService = feedViewModel.ProjectsFeed.DataServiceMock;
        //             LingoPhrase lingoPhrase = dataService.IterAllDefaultPhrases().Where(p => phraseKey == p.Key).First();
        //             dataService.SetPhraseTranslation(_translate(lingoPhrase, translation), langKey);

        //             var result = await dataService.SyncDataAsync();
        //         }
        //     }
        // }
    }
}

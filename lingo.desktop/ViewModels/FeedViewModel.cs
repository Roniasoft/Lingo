using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;
using System;
using System.Threading.Tasks;
using lingo.filer;
using lingo.common;

namespace lingo.desktop.ViewModels
{
    [Signal("openProjectRequested", NetVariantType.String)]
    public class FeedViewModel
    {
        [NotifySignal]
        public List<ProjectViewModel> Projects { get; set; }

        public Feed ProjectsFeed;
    

        internal FeedViewModel(Feed feed)
        {
            ProjectsFeed = feed;
            Projects = feed.Projects
                .Select(p => new ProjectViewModel(p))
                .ToList();
        }

        public void reload()
        {
            ProjectsFeed.reload();
            Projects = ProjectsFeed.Projects
                .Select(p => new ProjectViewModel(p))
                .ToList();
        }

        public bool IsProjectOpened(int projectId) =>
            Projects.FirstOrDefault(_ => _.ProjectId == projectId).IsOpen;

        public ProjectViewModel GetProjectViewModel(int projectId) =>
            Projects.FirstOrDefault(_ => _.ProjectId == projectId);

        public void MarkProjectOpened(int projectId) {
            Projects.FirstOrDefault(_ => _.ProjectId == projectId).IsOpen = true;
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
            List<ProjectViewModel> groups = this.Projects;
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
                    LingoFilerService dataService = this.ProjectsFeed.DataServiceMock;
                    common.ILingoGroup lingoGroup = dataService.IterAvailableGroups().Where(p => langKey == p.Key).First();
                    common.ILingoPhrase lingoPhrase = lingoGroup.IterPhrases().Where(p => phraseKey == p.Key).First();

                    ILingoPhraseTranslation lingoTranslation = new LingoPhraseTranslation(lingoPhrase, translation, !isCompleted);
                    lingoGroup.CommitPhraseTranslation(lingoTranslation);
                    var validateTranslation = lingoGroup.ValidatePhraseTranslation(lingoTranslation);

                    if (validateTranslation.IsValid) {
                        var result = await dataService.SyncDataAsync();
                    }
                    group.UntranslatedCounts = lingoGroup.GetUntranslated().ToArray().Length;
                    group.DirtyCounts = lingoGroup.GetDirtyTranslations().ToArray().Length;
                    group.UpdateTime = DateTime.Now.ToString("MM/dd/yyyy HH:mm");
                }
            }
            this.ActivateSignal("projectsChanged");
        }
    }
}

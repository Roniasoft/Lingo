using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;
using System;

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
    }
}

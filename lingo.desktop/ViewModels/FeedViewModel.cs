using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;
using System;

namespace lingo.desktop.ViewModels
{
    [Signal("openProjectRequested", NetVariantType.String)]
    public sealed class FeedViewModel
    {
        [NotifySignal]
        public List<ProjectViewModel> Projects { get; set; }

        internal FeedViewModel(Feed feed)
        {
            Projects = feed.Projects
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

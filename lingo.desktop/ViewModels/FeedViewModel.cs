using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;

namespace lingo.desktop.ViewModels
{
    [Signal("openProjectRequested", NetVariantType.String)]
    public sealed class FeedViewModel
    {
        private readonly HashSet<int> openedProjects;

        internal FeedViewModel(Feed feed)
        {
            Projects = feed.Projects
                .Select(_ => new ProjectViewModel(_))
                .ToList();

            openedProjects = new HashSet<int>();
        }

        public bool IsProjectOpened(int projectId)
        {
            return openedProjects.Contains(projectId);
        }

        public ProjectViewModel GetProjectViewModel(int projectId)
        {
            return Projects.First(_ => _.ProjectId == projectId);
        }

        public void MarkProjectOpened(int projectId)
        {
            openedProjects.Add(projectId);
        }

        public void OnItemClicked(int projectId)
        {
            if (openedProjects.Contains(projectId))
            {
                return;
            }

            openedProjects.Add(projectId);
            this.ActivateSignal("openProjectRequested", Projects.First(_ => _.ProjectId == projectId).Title);

        }

        [NotifySignal]
        public List<ProjectViewModel> Projects { get; set; }

    }
}

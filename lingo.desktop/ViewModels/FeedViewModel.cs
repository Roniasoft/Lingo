using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;

namespace lingo.desktop.ViewModels
{
    [Signal("openProjectRequested", NetVariantType.String)]
    public sealed class FeedViewModel
    {
        [NotifySignal]
        public List<ProjectViewModel> Projects { get; set; }

        readonly HashSet<int> _openedProjects;

        internal FeedViewModel(Feed feed)
        {
            Projects = feed.Projects
                .Select(p => new ProjectViewModel(p))
                .ToList();

            _openedProjects = new HashSet<int>();
        }

        public bool IsProjectOpened(int projectId) =>
            _openedProjects.Contains(projectId);

        public ProjectViewModel GetProjectViewModel(int projectId) =>
            Projects.FirstOrDefault(p => p.ProjectId == projectId);

        public void MarkProjectOpened(int projectId) => 
            _openedProjects.Add(projectId);

        public void OnItemClicked(int projectId)
        {
            if (_openedProjects.Contains(projectId))
                return;

            _openedProjects.Add(projectId);
            this.ActivateSignal("openProjectRequested", Projects.First(p => p.ProjectId == projectId).Title);
        }
    }
}

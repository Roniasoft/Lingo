using Qml.Net;
using lingo.desktop.Model;
using System;
using System.Threading.Tasks;

namespace lingo.desktop.ViewModels
{
    public sealed class ProjectViewModel
    {
        readonly private Project project;

        internal ProjectViewModel(Project project)
        {
            this.project = project;
        }

        public int ProjectId => project.Id;

        public string Title => project.Title;

        public string Summary => project.Summary;

        public bool IsOpen => project.IsOpen;

        [NotifySignal]
        public string UpdateTime
        {
            get
            {
                return project.UpdateTime.ToString();
            }

            set
            {
                var newTime = Convert.ToDateTime(value);
                if (project.UpdateTime == newTime)
                {
                    return;
                }

                project.UpdateTime = newTime;
            }
        }
    }
}

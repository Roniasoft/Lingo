using System.Collections.Generic;
using System.Linq;
using Qml.Net;
using lingo.desktop.Model;
using System;
using System.Threading.Tasks;

namespace lingo.desktop.ViewModels
{
    public sealed class ProjectViewModel
    {
        [NotifySignal]
        public List<PhraseViewModel> Phrases { get; set; }

        public int ProjectId => _project.Id;
        public string Title => _project.Title;
        public string Summary => _project.Summary;
        public bool IsOpen
        {
            get => _project.IsOpen;
            set
            {
                _project.IsOpen = value;
            }
        }

        readonly Project _project;

        internal ProjectViewModel(Project project)
        {
            _project = project;
        }

        [NotifySignal]
        public string UpdateTime
        {
            get => _project.UpdateTime.ToString();
            set
            {
                var newTime = Convert.ToDateTime(value);
                if (_project.UpdateTime == newTime)
                {
                    return;
                }

                _project.UpdateTime = newTime;
            }
        }
    }
}

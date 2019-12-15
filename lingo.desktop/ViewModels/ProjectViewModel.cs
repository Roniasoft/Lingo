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
        public List<PhraseViewModel> Phrases => _project.Phrases;

        public int ProjectId => _project.Id;

        public string LangKey => _project.LangKey;
        public string Title => _project.Title;
        public string Summary
        {
            get => _project.Summary;
            set
            {
                _project.Summary = value;
            }
        }
        public int UntranslatedCounts
        {
            get => _project.UntranslatedCounts;
            set {
                _project.UntranslatedCounts = value;
            }
        }
        public int DirtyCounts
        {
            get => _project.DirtyCounts;
            set {
                _project.DirtyCounts = value;
            }
        }
        public bool IsOpen
        {
            get => _project.IsOpen;
            set
            {
                _project.IsOpen = value;
            }
        }

        public string FilePath => _project.FilePath;

        readonly Project _project;

        internal ProjectViewModel(Project project)
        {
            _project = project;
        }

        public string UpdateTime
        {
            get => _project.UpdateTime.ToString("MM/dd/yyyy HH:mm");
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

        public PhraseViewModel GetPhraseViewModel(int index)
        {
            return Phrases.ElementAt(index);
        }

        public void ChangePhraseOpen(int index)
        {

            //_project.Phrases.ElementAt(index).IsOpen = true;
            //_project.Phrases.ElementAt(index).IsCompleted = true;
            //_project.Phrases.ElementAt(index).Translation = "heelo";
            Console.WriteLine("changed!");
            //_project.update();
        }
    }
}

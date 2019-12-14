using lingo.common;
using lingo.desktop.Model;
using lingo.desktop.ViewModels;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Threading.Tasks;
using lingo.filer;
using Qml.Net;
using System.IO;

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

        public void OpenTranslationsDir() {
            var rootPath = Path.GetDirectoryName(typeof(LingoFilerConfig).Assembly.Location) + "\\TranslationFiles";
            System.Diagnostics.Process.Start("explorer.exe" , rootPath);
        }
        public void OpenSelectedGroupItem(string filePath) {
            var rootPath = "/select, " + filePath;
            System.Diagnostics.Process.Start("explorer.exe", rootPath);
        }
        

    }
}

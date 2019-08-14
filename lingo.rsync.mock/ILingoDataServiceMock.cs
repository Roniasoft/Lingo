using lingo.common;
using System;
using System.Collections.Generic;
using System.Text;

namespace lingo.rsync.mock
{
    public interface ILingoDataServiceMock : ILingoDataService
    {
        void ResetMockData();

        bool IsOnline { get; set; }

        LingoPhrase AddBasePhrase(string key, string value, string description, string group = "DisplayText");
    }
}

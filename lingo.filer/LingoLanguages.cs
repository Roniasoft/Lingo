using System;

namespace lingo.filer
{
    static class LingoLanguages
    {
        static LingoLanguage _english;
        static LingoLanguage _spanish;
        static LingoLanguage _russian;

        const string EN = "en";
        const string ES = "es";
        const string RU = "ru";

        public static LingoLanguage English => _english ??
            (_english = new LingoLanguage(EN, "English"));
        public static LingoLanguage Spanish => _spanish ??
            (_spanish = new LingoLanguage(ES, "Español (Spanish)"));
        public static LingoLanguage Russian => _russian ??
            (_russian = new LingoLanguage(RU, "pусская (Russian)"));

        public static LingoLanguage GetLanguageFromKey(string langKey)
        {
            if (langKey == ES) return Spanish;
            if (langKey == RU) return Russian;
            if (langKey == EN) return English;

            throw new NotImplementedException("Language not yet supported");
        }

        public static LingoLanguage ParseLanguageFromFilename(string filename)
        {
            // Example only
            if (filename.EndsWith(".es.resx")) return Spanish;
            if (filename.EndsWith(".ru.resx")) return Russian;
            if (filename.EndsWith(".resx")) return English;

            throw new NotImplementedException("Language or file type not yet supported");
        }
    }
}

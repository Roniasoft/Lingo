#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,9,0,0,0,1,0,0,0,
150,0,0,0,0,0,1,0,0,0,0,0,0,0,42,0,
0,0,0,0,1,0,0,0,0,0,0,1,32,0,0,0,
0,0,1,0,0,0,0,0,0,0,180,0,0,0,0,0,
1,0,0,0,0,0,0,0,84,0,0,0,0,0,1,0,
0,0,0,0,0,0,106,0,0,0,0,0,1,0,0,0,
0,0,0,0,254,0,0,0,0,0,1,0,0,0,0,0,
0,0,8,0,0,0,0,0,1,0,0,0,0,0,0,0,
224,0,0,0,0,0,1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,14,15,204,123,60,0,84,0,
84,0,97,0,98,0,66,0,117,0,116,0,116,0,111,0,
110,0,46,0,113,0,109,0,108,0,18,0,198,66,124,0,
80,0,114,0,111,0,106,0,101,0,99,0,116,0,68,0,
101,0,116,0,97,0,105,0,108,0,115,0,46,0,113,0,
109,0,108,0,8,8,1,90,92,0,109,0,97,0,105,0,
110,0,46,0,113,0,109,0,108,0,19,11,103,168,220,0,
72,0,105,0,103,0,104,0,108,0,105,0,103,0,104,0,
116,0,66,0,117,0,116,0,116,0,111,0,110,0,46,0,
113,0,109,0,108,0,12,0,72,153,92,0,80,0,114,0,
111,0,106,0,101,0,99,0,116,0,115,0,46,0,113,0,
109,0,108,0,19,4,120,35,156,0,68,0,101,0,116,0,
97,0,105,0,108,0,101,0,100,0,83,0,101,0,99,0,
116,0,105,0,111,0,110,0,46,0,113,0,109,0,108,0,
12,15,223,34,60,0,83,0,101,0,116,0,116,0,105,0,
110,0,103,0,115,0,46,0,113,0,109,0,108,0,14,14,
112,126,28,0,70,0,108,0,97,0,116,0,66,0,117,0,
116,0,116,0,111,0,110,0,46,0,113,0,109,0,108,0,
14,2,40,25,28,0,78,0,101,0,119,0,80,0,114,0,
111,0,106,0,101,0,99,0,116,0,46,0,113,0,109,0,
108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace _0x5f__NewProject_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__FlatButton_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Settings_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__DetailedSection_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Projects_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__HighlightButton_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__main_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__ProjectDetails_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__TTabButton_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/NewProject.qml"), &QmlCacheGeneratedCode::_0x5f__NewProject_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/FlatButton.qml"), &QmlCacheGeneratedCode::_0x5f__FlatButton_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Settings.qml"), &QmlCacheGeneratedCode::_0x5f__Settings_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/DetailedSection.qml"), &QmlCacheGeneratedCode::_0x5f__DetailedSection_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Projects.qml"), &QmlCacheGeneratedCode::_0x5f__Projects_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/HighlightButton.qml"), &QmlCacheGeneratedCode::_0x5f__HighlightButton_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/main.qml"), &QmlCacheGeneratedCode::_0x5f__main_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/ProjectDetails.qml"), &QmlCacheGeneratedCode::_0x5f__ProjectDetails_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/TTabButton.qml"), &QmlCacheGeneratedCode::_0x5f__TTabButton_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}
const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qml)() {
    ::unitRegistry();
    Q_INIT_RESOURCE(qml_qmlcache);
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qml))
int QT_MANGLE_NAMESPACE(qCleanupResources_qml)() {
    Q_CLEANUP_RESOURCE(qml_qmlcache);
    return 1;
}

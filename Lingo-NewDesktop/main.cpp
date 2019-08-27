#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlContext>
#include <QIcon>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("runningFromQt", true);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    engine.rootObjects().first()->setProperty("runningFromQt", true);
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}

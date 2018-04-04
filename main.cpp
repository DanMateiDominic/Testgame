#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <level_loader/levelloader.h>
#include <box2dplugin.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Box2DPlugin plugin;
    plugin.registerTypes("Box2DStatic");

    qmlRegisterType<LevelLoader, 1>("LevelLoader", 1, 0, "LevelLoader");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

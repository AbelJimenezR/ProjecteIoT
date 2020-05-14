#include "contenidor.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QThread>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    Contenidor c;
    c.connecta();

    qmlRegisterType<Contenidor>("io.qt.examples.contenidor", 1, 0, "Contenidor");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    /*QQmlContext* context = engine.rootContext();
    context->setContextProperty("listModel",QVariant::fromValue(c.listModel()));*/
    engine.load(url);

    return app.exec();
}

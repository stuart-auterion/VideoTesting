
#include <gst/gst.h>

#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QTimer>

#include "videoManager.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    VideoManager videoManager;
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    engine.addImportPath("qrc:/src/");
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url, &videoManager](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl) {
                QCoreApplication::exit(-1);
            } else {
                videoManager.setRootObject(obj);
            }
        },
        Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("VideoManager", &videoManager);
    engine.load(url);

    return app.exec();
}

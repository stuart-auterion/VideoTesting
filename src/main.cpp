#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#ifdef __ANDROID__
#include "mobileScreenManager.h"
#endif
//#include <gst/gst.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Test");
    QCoreApplication::setOrganizationDomain("Test");

//    gst_init(NULL,NULL);
//    GstElement *sink = gst_element_factory_make ("qmlglsink", NULL);
//    gst_object_unref(sink);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

#ifdef __ANDROID__
    MobileScreenManager mobileScreenManager(nullptr);
    engine.rootContext()->setContextProperty("MobileScreenManager", &mobileScreenManager);
#endif /* __ANDROID__ */

    engine.load(url);

    return app.exec();
}

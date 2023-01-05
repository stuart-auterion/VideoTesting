#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <gst/gst.h>

class Streamer : public QObject {
    Q_OBJECT
public:
    Streamer(QObject* parent = NULL) : QObject(parent) {
        gst_init(NULL, NULL);
        GstElement *tempsink = gst_element_factory_make("qmlglsink", NULL);
        gst_object_unref(tempsink);
    };
    ~Streamer() {};
    void setEngine(QQmlApplicationEngine* engine) { m_engine = engine; }
    Q_INVOKABLE void init() {
        GError* error = NULL;
        m_pipeline = gst_parse_launch("videotestsrc ! glupload ! qmlglsink name=\"qmlglsink\"", &error);
        if(error) {
            qDebug() << error->message;
        }
        Q_ASSERT(m_pipeline != NULL);
        GstElement* sink = gst_bin_get_by_name(GST_BIN(m_pipeline), "qmlglsink");
        Q_ASSERT(sink != NULL);
        QObject* rootObject = m_engine->rootObjects().first();
        Q_ASSERT(rootObject != NULL);
        QQuickItem* const widget = rootObject->findChild<QQuickItem*>("videoItem");
        Q_ASSERT(widget != NULL);
        g_object_set(sink, "widget", widget, NULL);
        qDebug() << gst_element_set_state(m_pipeline, GST_STATE_PLAYING);
//        qDebug() << gst_debug_bin_to_dot_data(GST_BIN(m_pipeline), GST_DEBUG_GRAPH_SHOW_ALL);
    };
private:
    GstElement* m_pipeline;
    QQmlApplicationEngine* m_engine;
};

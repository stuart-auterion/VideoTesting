#include "videoManager.h"

#include <gst/gst.h>

#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QUuid>
#include <QtGlobal>

/******************************************************************************
 * GStreamer initialization
 *****************************************************************************/
static bool initialized = false;

G_BEGIN_DECLS
// The static plugins we use
#ifdef Q_OS_ANDROID
GST_PLUGIN_STATIC_DECLARE(coreelements);
GST_PLUGIN_STATIC_DECLARE(playback);
GST_PLUGIN_STATIC_DECLARE(libav);
GST_PLUGIN_STATIC_DECLARE(rtp);
GST_PLUGIN_STATIC_DECLARE(rtsp);
GST_PLUGIN_STATIC_DECLARE(udp);
GST_PLUGIN_STATIC_DECLARE(videoparsersbad);
GST_PLUGIN_STATIC_DECLARE(x264);
GST_PLUGIN_STATIC_DECLARE(rtpmanager);
GST_PLUGIN_STATIC_DECLARE(isomp4);
GST_PLUGIN_STATIC_DECLARE(matroska);
GST_PLUGIN_STATIC_DECLARE(mpegtsdemux);
GST_PLUGIN_STATIC_DECLARE(opengl);
GST_PLUGIN_STATIC_DECLARE(androidmedia);
GST_PLUGIN_STATIC_DECLARE(videotestsrc);
#endif
GST_PLUGIN_STATIC_DECLARE(qmlgl);
G_END_DECLS

#ifdef Q_OS_ANDROID
#include <android/log.h>
static void gst_android_log(GstDebugCategory* category, GstDebugLevel level, const gchar* file,
                            const gchar* function, gint line, GObject* object,
                            GstDebugMessage* message, gpointer data) {
    if (level <= gst_debug_category_get_threshold(category)) {
        __android_log_print(ANDROID_LOG_ERROR, "GST", "%s, %s: %s", file, function,
                            gst_debug_message_get(message));
    }
    Q_UNUSED(line)
    Q_UNUSED(object)
    Q_UNUSED(data)
}
#endif

void initVideo() {
#ifdef Q_OS_ANDROID
    gst_debug_add_log_function(gst_android_log, nullptr, nullptr);
#endif
    gst_init(0, 0);
#ifdef Q_OS_ANDROID
    GST_PLUGIN_STATIC_REGISTER(coreelements);
    GST_PLUGIN_STATIC_REGISTER(playback);
    GST_PLUGIN_STATIC_REGISTER(libav);
    GST_PLUGIN_STATIC_REGISTER(rtp);
    GST_PLUGIN_STATIC_REGISTER(rtsp);
    GST_PLUGIN_STATIC_REGISTER(udp);
    GST_PLUGIN_STATIC_REGISTER(videoparsersbad);
    GST_PLUGIN_STATIC_REGISTER(x264);
    GST_PLUGIN_STATIC_REGISTER(rtpmanager);
    GST_PLUGIN_STATIC_REGISTER(isomp4);
    GST_PLUGIN_STATIC_REGISTER(matroska);
    GST_PLUGIN_STATIC_REGISTER(mpegtsdemux);
    GST_PLUGIN_STATIC_REGISTER(opengl);
    GST_PLUGIN_STATIC_REGISTER(androidmedia);
    GST_PLUGIN_STATIC_REGISTER(videotestsrc);
#endif
    GstElement* sink = gst_element_factory_make("qmlglsink", nullptr);
    if (sink == nullptr) {
        GST_PLUGIN_STATIC_REGISTER(qmlgl);
        sink = gst_element_factory_make("qmlglsink", nullptr);
        Q_UNUSED(sink)
    }
    qmlRegisterType<VideoStream>("Video", 1, 0, "VideoStream");
    qRegisterMetaType<VideoStream*>();
    initialized = true;
}

/******************************************************************************
 * VideoStream class
 *****************************************************************************/
VideoStream::VideoStream(QObject* parent) : QObject(parent) {
    if (!initialized) {
        qDebug() << "not initialized!";
    }
    _timer.setInterval(50);
    connect(&_timer, &QTimer::timeout, this, &VideoStream::start);
}

void VideoStream::start() {
    if (_pipeline != nullptr) {
        GstState state;
        gst_element_get_state(_pipeline, &state, nullptr, 10);
        if (state != GST_STATE_PLAYING) {
            gst_element_set_state(_pipeline, GST_STATE_PLAYING);
        }
    }
}

void VideoStream::stop() {
    if (_pipeline != nullptr) {
        GstState state;
        gst_element_get_state(_pipeline, &state, nullptr, 10);
        if (state == GST_STATE_PLAYING) {
            gst_element_set_state(_pipeline, GST_STATE_PAUSED);
        }
    }
}

void VideoStream::createPipeline() {
    // If we're missing information
    if ((_gstVideoItem == nullptr) || (_type == INVALID) || (_uri.isEmpty() && (_type != TEST))) {
        return;
    }
    if (_pipeline != nullptr) {
        gst_element_set_state(_pipeline, GST_STATE_NULL);
        _pipeline = nullptr;
    }
    QString pipelineString;
    switch (_type) {
        case RTSP:
            pipelineString = QString(
                                 "rtspsrc location=rtsp://%1 ! rtpjitterbuffer ! parsebin ! queue  "
                                 "! decodebin ! glupload ! glcolorconvert ! qmlglsink name=qmlsink")
                                 .arg(_uri);
            break;
        case RTPUDP:
            // gst-launch-1.0 -v videotestsrc !
            // "video/x-raw,format=I420,width=1920,height=1080,framerate=60/1" ! x264enc
            // tune=zerolatency bitrate=500 speed-preset=superfast ! rtph264pay ! udpsink port=5004
            // host=127.0.0.1
            pipelineString = QString(
                                 "udpsrc port=5004 ! application/x-rtp, media=(string)video, "
                                 "clock-rate=(int)90000, encoding-name=(string)H264, "
                                 "payload=(int)96 ! parsebin ! queue ! decodebin ! glupload ! "
                                 "glcolorconvert ! qmlglsink name=qmlsink")
                                 .arg(_uri);
            break;
        case TEST:
            pipelineString =
                QString("videotestsrc ! glupload ! glcolorconvert ! qmlglsink name=qmlsink");
            break;
        case INVALID:
        default:
            return;
    }
    qDebug() << pipelineString.toStdString().c_str();
    _pipeline = gst_pipeline_new(NULL);
    _pipeline = gst_parse_launch(pipelineString.toStdString().c_str(), NULL);
    GstElement* sink = gst_bin_get_by_name(GST_BIN(_pipeline), "qmlsink");
    g_object_set(sink, "widget", _gstVideoItem, NULL);
}

bool VideoStream::autoplay() const {
    return _autoplay;
}

QObject* VideoStream::gstVideoItem() const {
    return _gstVideoItem;
}

VideoStream::Type VideoStream::type() const {
    return _type;
}

QString VideoStream::uri() const {
    return _uri;
}

void VideoStream::setAutoplay(bool newAutoplay) {
    if (_autoplay != newAutoplay) {
        _autoplay = newAutoplay;
        emit autoplayChanged();
    }
    if (_autoplay) {
        if (!_timer.isActive()) {
            _timer.start();
        }
    } else {
        _timer.stop();
    }
}

void VideoStream::setGstVideoItem(QObject* newGstVideoItem) {
    if (_gstVideoItem != newGstVideoItem) {
        _gstVideoItem = newGstVideoItem;
        emit gstVideoItemChanged();
        createPipeline();
    }
}

void VideoStream::setType(Type newType) {
    if (_type != newType) {
        _type = newType;
        emit typeChanged();
        createPipeline();
    }
}

void VideoStream::setUri(const QString& newUri) {
    if (_uri != newUri) {
        _uri = newUri;
        emit uriChanged();
        createPipeline();
    }
}

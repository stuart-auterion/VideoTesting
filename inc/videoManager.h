#pragma once

#include <gst/gst.h>

#include <QObject>
#include <QUuid>

class VideoStream : public QObject {
    Q_OBJECT
  public:
    VideoStream(QObject* parent = nullptr);
    VideoStream(QObject* parent, QObject* object);
    Q_INVOKABLE void play();

  private:
    QObject* _object = nullptr;
    GstElement* _pipeline = nullptr;
};

Q_DECLARE_METATYPE(VideoStream*)

class VideoManager : public QObject {
    Q_OBJECT
  public:
    VideoManager(QObject* parent = nullptr);
    Q_INVOKABLE VideoStream* addStream(QObject* object);
    void setRootObject(QObject* object);

  private:
    QObject* _rootObject = nullptr;
    QList<VideoStream*> _videoStreams;
};

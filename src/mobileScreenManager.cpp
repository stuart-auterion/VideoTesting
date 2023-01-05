#include "mobileScreenManager.h"

#include <QtAndroidExtras/QtAndroidExtras>
#include <QtAndroidExtras/QAndroidJniObject>

static const char* jniClassName = "org/test/test/TestActivity";

MobileScreenManager::MobileScreenManager(QObject* parent)
    : QObject(parent) {
    m_recordingsFolder = QDir::toNativeSeparators(
                QString("%1/%2/%3").arg(
                    QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
                    "Test",
                    "Video"));
    qDebug() << "Attempting to make path: "
             << m_recordingsFolder << " - "
             << QDir().mkpath(m_recordingsFolder);
}

void MobileScreenManager::startScreenRecording() {
    QString filename = QDateTime::currentDateTime().toString("yyyy-MM-dd-hh-mm-ss");
    QAndroidJniObject jFilename = QAndroidJniObject::fromString(filename);
    QAndroidJniObject jFilepath = QAndroidJniObject::fromString(m_recordingsFolder);
    QAndroidJniObject::callStaticMethod<void>(jniClassName,
                                              "startScreenRecording",
                                              "(Ljava/lang/String;Ljava/lang/String;)V",
                                              jFilepath.object<jstring>(),
                                              jFilename.object<jstring>());
    m_recording = true;
    emit recordingChanged();
}

void MobileScreenManager::stopScreenRecording() {
    QAndroidJniObject::callStaticMethod<void>(jniClassName, "stopScreenRecording");
    m_recording = false;
    emit recordingChanged();
}

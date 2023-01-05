#ifndef MOBILESCREENMANAGER_H
#define MOBILESCREENMANAGER_H

#include <QObject>

class MobileScreenManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool recording MEMBER m_recording NOTIFY recordingChanged)
    Q_PROPERTY(QString recordingsFolder MEMBER m_recordingsFolder NOTIFY recordingsFolderChanged)
public:
    MobileScreenManager(QObject* parent = nullptr);
    Q_INVOKABLE void startScreenRecording();
    Q_INVOKABLE void stopScreenRecording();
signals:
    void recordingChanged();
    void recordingsFolderChanged();
private:
    bool m_recording = false;
    QString m_recordingsFolder;
};

#endif /* MOBILESCREENMANAGER_H */

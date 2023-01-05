import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 640
    height: 800
    visible: true
    title: qsTr("Hello World")

    ScreenRecordingTest {}

    VideoTest {}

}

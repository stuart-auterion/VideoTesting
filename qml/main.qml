import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import Video 1.0

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    property bool uriSwitch: false
    Timer {
        interval: 5000
        repeat: true
        running: true
        // Test dynamically recreating the stream
        onTriggered: uriSwitch = !uriSwitch
    }
    Column {
        anchors.fill: parent
        VideoPlayer {
            type: VideoStream.TEST
            width: 200
            height: 480/640 * width
        }
        VideoPlayer {
            uri: uriSwitch ? "admin:jCTpYyt1g46x9zPn@192.168.2.21:554/cam/realmonitor?channel=1&subtype=0" : "admin:jCTpYyt1g46x9zPn@192.168.2.23:554/cam/realmonitor?channel=1&subtype=0"
            type: VideoStream.RTSP
            width: 200
            height: 480/640 * width
        }
        VideoPlayer {
            uri: uriSwitch ? "admin:jCTpYyt1g46x9zPn@192.168.2.23:554/cam/realmonitor?channel=1&subtype=0" : "admin:jCTpYyt1g46x9zPn@192.168.2.21:554/cam/realmonitor?channel=1&subtype=0"
            type: VideoStream.RTSP
            width: 200
            height: 480/640 * width
        }
    }
}

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    VideoPlayer {
        id: video
        autoplay: true
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }
}

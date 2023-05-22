import QtQuick 2.15

import org.freedesktop.gstreamer.GLVideoItem 1.0

GstGLVideoItem {
    id: video
    property var videoStreamObject
    property bool autoplay: true
    Component.onCompleted: {
        videoStreamObject = VideoManager.addStream(this)
    }
    MouseArea {
        anchors.fill: parent
        onClicked: videoStreamObject.play()
    }
}

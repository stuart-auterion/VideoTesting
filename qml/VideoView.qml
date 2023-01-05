import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Item {
    id: root
    property alias uri: player.source
    property alias sourceRect: video.sourceRect
    signal stopped
    MediaPlayer {
        id: player
        autoPlay: true
        videoOutput: video
        Component.onDestruction: stop()
        property int lastPosition: 0
        property bool stopped: true
        onPositionChanged: {
            if(position === lastPosition && lastPosition !== 0){
                if(!stopped) {
                    root.stopped()
                    stopped = true
                }
            } else {
                stopped = false
                lastPosition = position
            }
        }
        onError: console.log(errorString)

    }
    VideoOutput {
        id: video
        anchors.fill: parent
    }
    Rectangle {
        anchors.fill: parent
        color: player.stopped ? "white" : "transparent"
        border.width: 1
        border.color: "black"
        Text {
            visible: player.stopped
            text: "No data"
            anchors.centerIn: parent
        }
    }
}

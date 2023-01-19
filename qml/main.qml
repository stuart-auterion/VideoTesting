import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    MediaPlayer {
        id: player
        autoPlay: true
        source: "gst-pipeline: videotestsrc ! qtvideosink"
//        /* RTP over UDP: X2D IR feed */
//        /* RTP over UDP: X2D E0 feed */
//        /* RTSP: Back Yard Cam */
//        /* RTSP: Front Yard Cam */
//        source: protocolSwitch.checked       /* alternatively: uri:udp://0.0.0.0:5600 */
//                ? (videoSwitch.checked ? "gst-pipeline: udpsrc port=5602 caps=\"application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264\" ! parsebin ! queue ! decodebin ! autovideosink"
//                                       : "gst-pipeline: udpsrc port=5600 caps=\"application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264\" ! parsebin ! queue ! decodebin ! autovideosink")
//                : (videoSwitch.checked ? "rtsp://admin:jCTpYyt1g46x9zPn@192.168.2.23:554/cam/realmonitor?channel=1&subtype=0"
//                                       : "rtsp://admin:jCTpYyt1g46x9zPn@192.168.2.21:554/cam/realmonitor?channel=1&subtype=0")
        videoOutput: video
    }
    VideoOutput {
        id: video
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        height: (sourceRect.height / sourceRect.width) * width
        width: 400
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.width: 1
            border.color: "black"
        }
    }
    RowLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        height: 50
        visible: false
        Text {
            text: protocolSwitch.checked ? "E0" : "Front yard"
            Layout.preferredHeight: parent.height
            verticalAlignment: Qt.AlignVCenter
        }
        Switch {
            id: videoSwitch
            Layout.preferredHeight: parent.height
        }
        Text {
            text: protocolSwitch.checked ? "IR" : "Back yard"
            Layout.preferredHeight: parent.height
            verticalAlignment: Qt.AlignVCenter
        }
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
        }
        Text {
            text: "RTSP"
            Layout.preferredHeight: parent.height
            verticalAlignment: Qt.AlignVCenter
        }
        Switch {
            id: protocolSwitch
            height: parent.height
        }
        Text {
            text: "RTP over UDP"
            Layout.preferredHeight: parent.height
            verticalAlignment: Qt.AlignVCenter
        }
    }
}

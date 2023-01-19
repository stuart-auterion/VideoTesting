import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
//import org.freedesktop.gstreamer.GLVideoItem 1.0

Item {
    anchors.fill: parent
    //    VideoView {
    //        uri: "gst-pipeline: videotestsrc ! qtvideosink"
    //        width: 200
    //        height: (sourceRect.height / sourceRect.width) * width
    //        onStopped: console.log("Stream stopped!")
    //    }
    //    GstGLVideoItem {
    //        id: videoItem
    //        objectName: "videoItem"
    //        x: 10
    //        y: 10
    //        width: 200
    //        height: 200
    //        Rectangle {
    //            anchors.fill: parent
    //            color: "transparent"
    //            border.width: 1
    //            border.color: "black"
    //        }
    //        Component.onCompleted: stupid.start()
    //        Timer {
    //            id: stupid
    //            interval: 500
    //            onTriggered: Streamer.init()
    //        }
    //    }

    GridLayout {
        columns: 2
//        VideoView {
//            uri: "rtsp://admin:jCTpYyt1g46x9zPn@192.168.2.21:554/cam/realmonitor?channel=1&subtype=0"
//            width: 200
//            height: (sourceRect.height / sourceRect.width) * width
//        }
//        VideoView {
//            uri: "rtsp://admin:jCTpYyt1g46x9zPn@192.168.2.23:554/cam/realmonitor?channel=1&subtype=0"
//            width: 200
//            height: (sourceRect.height / sourceRect.width) * width
//        }
//        VideoView {
//            uri: "gst-pipeline: udpsrc port=5600 caps=\"application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264\" ! rtpjitterbuffer ! parsebin ! queue ! decodebin ! qtvideosink"
//            width: 200
//            height: (sourceRect.height / sourceRect.width) * width
//        }
//        VideoView {
//            uri: "gst-pipeline: udpsrc port=5602 caps=\"application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264\" ! rtpjitterbuffer ! parsebin ! queue ! decodebin ! qtvideosink"
//            width: 200
//            height: (sourceRect.height / sourceRect.width) * width
//        }

//        VideoView {
//            // Launch with:
//            // gst-launch-1.0 -v videotestsrc ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! rtph264pay ! udpsink port=5000 host=127.0.0.1
//            uri: "gst-pipeline: udpsrc port=5000 caps=\"application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, payload=(int)96\" ! parsebin ! queue ! decodebin ! videoconvert ! qtvideosink"
//            width: 200
//            height: (sourceRect.height / sourceRect.width) * width
//            onStopped: console.log("Stream stopped!")
//        }
        VideoView {
            uri: "gst-pipeline: videotestsrc ! qtvideosink"
            width: 200
            height: (sourceRect.height / sourceRect.width) * width
            onStopped: console.log("Stream stopped!")
        }
//        Item {
//            width: 200
//            height: (video.sourceRect.height / video.sourceRect.width) * width
//            MediaPlayer {
//                id: player
//                autoPlay: true
//                videoOutput: video
//                source: "udp://0.0.0.0:5600"
//            }
//            VideoOutput {
//                id: video
//                anchors.fill: parent
//            }
//            Rectangle {
//                anchors.fill: parent
//                color: "transparent"
//                border.width: 1
//                border.color: "black"
//            }
//        }
    }

    // Parent change testing
    //    Rectangle {
    //        id: parent1
    //        width: 100
    //        height: 100
    //        anchors.left: parent.left
    //        anchors.top: parent.top
    //        color: "red"
    //        opacity: 0.5
    //    }
    //    Item {
    //        anchors.fill: parent
    //        Loader {
    //            id: parent2Loader
    //            anchors.fill: parent
    //            sourceComponent: Item {
    //                property alias parent2Alias: parent2
    //                anchors.fill: parent
    //                Item {
    //                    anchors.fill: parent
    //                    Rectangle {
    //                        id: parent2
    //                        width: 100
    //                        height: 100
    //                        anchors.right: parent.right
    //                        anchors.top: parent.top
    //                        color: "blue"
    //                        opacity: 0.5
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    Rectangle {
    //        id: movableItem
    //        width: 30
    //        height: 30
    //        color: "black"
    //        anchors.centerIn: parent
    //        state: "parent1State"
    //        states: [
    //            State {
    //                name: "parent1State"
    //                ParentChange { target: movableItem; parent: parent1; }
    //            },
    //            State {
    //                name: "parent2State"
    //                ParentChange { target: movableItem; parent: parent2Loader.item.parent2Alias; }
    //            }
    //        ]
    //    }
    //    Button {
    //        text: "Reparent"
    //        anchors.top: parent.top
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        onPressed: {
    //            if(movableItem.state === "parent1State") {
    //                movableItem.state = "parent2State"
    //            } else {
    //                movableItem.state = "parent1State"
    //            }
    //        }
    //    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.15

Item {
    anchors.fill: parent

    Column {
        x: 10
        y: 10
        spacing: 10
        Button {
            text: MobileScreenManager.recording ? "Stop" : "Start"
            onClicked: MobileScreenManager.recording ? MobileScreenManager.stopScreenRecording()
                                                     : MobileScreenManager.startScreenRecording()
        }
    }
    ListView {

    }
    ListView {
        width: 300
        height: 400
        x: 10
        y: 250
        model: MobileScreenManager.recordingFiles
        delegate: Rectangle {
            height: 60
            width: parent.width
            color: "lightgrey"
            Text {
                anchors.fill: parent
                text: modelData
                verticalAlignment: Text.AlignHCenter
            }
            Row {
                anchors.fill: parent
                layoutDirection: Qt.RightToLeft
                Image {
                    width: height
                    height: parent.height
                    antialiasing: true
                    sourceSize: Qt.size(24, 24)
                    source: "qrc:/img/share.svg"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: MobileScreenManager.shareFile(MobileScreenManager.recordingsFolder + "/" + modelData, "video/mp4")
                    }
                }
                Image {
                    width: height
                    height: parent.height
                    antialiasing: true
                    sourceSize: Qt.size(24, 24)
                    source: "qrc:/img/trash.svg"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: MobileScreenManager.deleteFile(MobileScreenManager.recordingsFolder + "/" + modelData)
                    }
                }
            }
        }
        Rectangle {
            color: "transparent"
            border.color: "black"
            border.width: 1
            anchors.fill: parent
        }
    }
}

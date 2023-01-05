import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1

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
        Button {
            text: "View recordings"
            onClicked: fileDialog.open()
        }
    }
    FolderDialog {
        id: fileDialog
        folder: MobileScreenManager.recordingsFolder
    }
}

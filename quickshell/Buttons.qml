import QtQuick.Layouts
import QtQuick
import Quickshell

RowLayout {
    id: buttons

    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right

    Rectangle {
        id: power_button
        function openPowerMenu() {
            console.log("FUCK");
        }
        implicitWidth: 30
        implicitHeight: 30
        radius: 4
        color: "black"

        property bool shown: false

        Image {
            anchors.fill: parent
            source: "power.svg"
            // color
            // j
        }

        MouseArea {
            anchors.fill: parent
            // onClicked: power_button.shown = true
            onClicked: PowerMenu.show()
            cursorShape: Qt.PointingHandCursor
        }

        // Rectangle {
        //     height: 40
        //     width: 40
        //     anchors.top: parent.bottom

        // }

        // PopupWindow {
        //     anchor.window: buttons
        //     visible: true
        //     implicitHeight: 40
        //     implicitWidth: 40
        //     color: "red"
        // }
    }
}

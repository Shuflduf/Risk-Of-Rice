import QtQuick.Layouts
import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects

Rectangle {

    // anchors.verticalCenter: parent.verticalCenter
    anchors.top: parent.top
    anchors.right: parent.right
    color: Colours.bg
    implicitWidth: 400
    implicitHeight: 38

    RowLayout {
        id: buttons
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.rightMargin: 4

        BatteryWidget {}
        Item {
            // anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: 30
            implicitHeight: 30

            Image {
                id: icon
                anchors.fill: parent
                source: "power.svg"
            }

            ColorOverlay {
                anchors.fill: icon
                source: icon
                color: Colours.clock
            }

            MouseArea {
                anchors.fill: parent
                // onClicked: power_button.shown = true
                onClicked: PowerMenu.show()
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}

import QtQuick.Layouts
import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects

Rectangle {

    // anchors.verticalCenter: parent.verticalCenter
    anchors.top: parent.top
    anchors.right: parent.right
    color: Colours.bg
    implicitWidth: buttons.implicitWidth - 25
    implicitHeight: 38

    RowLayout {
        id: buttons
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.rightMargin: 4

        Item {
            implicitHeight: 32
            implicitWidth: 32
            Layout.fillHeight: true

            Image {
                anchors.fill: parent
                source: "panel_end.png"
                smooth: false
                // Layout.fillHeight: parent
                // anchors.fill: parent
                // implicitHeight: 30
            }
        }

        SpotifyWidget {}
        SoundWidget {}
        BluetoothWidget {}
        WifiWidget {}
        BatteryWidget {}
        Item {
            // anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: 32
            implicitHeight: 32

            Image {
                id: icon
                anchors.fill: parent
                source: "power_button.png"
                smooth: false
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

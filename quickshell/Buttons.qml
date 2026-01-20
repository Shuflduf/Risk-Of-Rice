import QtQuick.Layouts
import QtQuick

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

        Image {
            anchors.fill: parent
            source: "power.svg"
            // color
            // j
        }

        MouseArea {
            anchors.fill: parent
            onClicked: PowerMenu.showPowerMenu()
            cursorShape: Qt.PointingHandCursor
        }
    }
}

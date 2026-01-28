import QtQuick.Layouts
import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import Quickshell.Services.SystemTray

Row {
    spacing: 4

    Repeater {
        model: SystemTray.items

        Item {
            id: tray_item
            implicitHeight: 16
            implicitWidth: 16
            required property SystemTrayItem modelData
            // Text {
            //     text: tray_item.modelData.title
            // }
            Image {
                anchors.fill: parent
                source: tray_item.modelData.icon
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: tray_item.modelData.activate()
            }
        }
    }
}

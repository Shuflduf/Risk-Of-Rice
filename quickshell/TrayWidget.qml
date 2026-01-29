import QtQuick.Layouts
import QtQuick
import Quickshell
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import Quickshell.Services.SystemTray
import QtQuick.Controls

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
            // Icon {
            //     source: tray_item.modelData.icon
            // }
            // Button {
            //     anchors.fill: parent
            //     icon.source: tray_item.modelData.icon
            // }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        tray_item.modelData.activate();
                    } else if (mouse.button == Qt.RightButton) {
                        var pos = mapToItem(null, mouse.x, mouse.y);
                        tray_item.modelData.display(tray_item.QsWindow.window, pos.x, pos.y);
                    } else if (mouse.button == Qt.MiddleButton) {
                        tray_item.modelData.secondaryActivate();
                    }
                }
            }
        }
    }
}

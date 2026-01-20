import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    id: workspaces
    property string activeWindowName: "FUCK"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    spacing: 2

    function updateWindowName() {
        Hyprland.refreshToplevels();
        let actualTopLevel = Hyprland.toplevels.values.find(tl => tl.activated && tl.workspace.id == Hyprland.focusedWorkspace.id);
        if (actualTopLevel && actualTopLevel.lastIpcObject && actualTopLevel.lastIpcObject.initialTitle) {
            workspaces.activeWindowName = actualTopLevel.lastIpcObject.initialTitle;
        } else {
            workspaces.activeWindowName = "FUCK";
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(event => {
            updateWindowName();
        });
    }

    Repeater {
        model: Hyprland.workspaces
        Item {
            id: workspace_button
            required property HyprlandWorkspace modelData
            property bool shouldNameBeVisible: (modelData.focused && modelData.toplevels.values.length > 0)

            implicitWidth: 30 + active_window_container.implicitWidth
            implicitHeight: 30

            Item {
                id: workspace_name
                implicitWidth: 30
                implicitHeight: 30

                RectangularShadow {
                    anchors.fill: parent
                    offset: Qt.vector2d(0.0, 5.0)
                    spread: 1
                    color: Qt.rgba(0.0, 0.0, 0.0, 0.7)
                }
                Rectangle {
                    color: "#494A5B"
                    radius: 4
                    anchors.fill: parent
                    anchors.margins: 1
                }
                ClippingRectangle {
                    anchors.margins: 4
                    anchors.fill: parent
                    radius: 4
                    color: workspace_button.modelData.focused ? "#476894" : "#3B3542"
                    width: 26
                    height: 26

                    RectangularShadow {
                        offset: Qt.vector2d(-5.0, -5.0)
                        width: 30
                        height: 8
                        blur: 1
                        color: "#1A1A1A"
                        opacity: 0.5
                    }
                    Text {
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: 1
                        text: workspace_button.modelData.name
                        color: workspace_button.modelData.focused ? "#FFFFFF" : "#A5ACB5"

                        font {
                            pixelSize: 14
                            family: "RZPix"
                            bold: true
                        }
                    }
                }
                Image {
                    id: select
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 30
                    width: 30
                    visible: workspace_button.modelData.focused
                    Component.onCompleted: workspace_button.modelData.focusedChanged.connect(select_anim.start)

                    PropertyAnimation {
                        id: select_anim
                        target: select
                        properties: "width,height"
                        from: 70
                        to: 30
                        duration: 150
                        easing.type: Easing.OutBack
                    }
                    source: "selection.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: workspace_button.modelData.activate()
                    cursorShape: Qt.PointingHandCursor
                }
            }
            Rectangle {
                id: active_window_container
                property real expandedWidth: active_window_text.width + 20
                implicitWidth: 0

                Component.onCompleted: workspaces.activeWindowNameChanged.connect(() => {
                    active_window_container.implicitWidth = workspace_button.shouldNameBeVisible ? expandedWidth : 0;
                })

                implicitHeight: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                x: 29
                z: -1
                color: "#494A5B"
                radius: 4

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutBack
                    }
                }

                ClippingRectangle {
                    anchors.leftMargin: 0
                    anchors.margins: 3
                    anchors.fill: parent

                    color: "#343A4D"

                    RectangularShadow {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 2
                        blur: 1
                    }

                    Text {
                        id: active_window_text
                        anchors.centerIn: parent
                        text: workspaces.activeWindowName
                        color: "#A5ACB5"
                        visible: active_window_container.implicitWidth > 0
                        font {
                            pixelSize: 13
                            family: "RZPix"
                        }
                    }
                }
            }
        }
    }
}

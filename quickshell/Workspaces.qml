import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland

RowLayout {
    id: workspaces
    property string activeWindowName: "FUCK"
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    spacing: 2

    function updateTopLevelName() {
        Hyprland.refreshToplevels();
        let realTopLevel = Hyprland.toplevels.values.find(tl => tl.activated && tl.workspace.id == Hyprland.focusedWorkspace.id);
        if (realTopLevel && realTopLevel.lastIpcObject.initialTitle) {
            activeWindowName = realTopLevel.lastIpcObject.initialTitle;
        }
    }
    Component.onCompleted: {
        Hyprland.rawEvent.connect(event => {
            updateTopLevelName();
        });
        Hyprland.toplevels.valuesChanged.connect(updateTopLevelName);
    }

    Repeater {
        model: Hyprland.workspaces
        Item {
            id: workspace_button
            required property HyprlandWorkspace modelData
            property bool shouldNameBeVisible: (modelData.focused && modelData.toplevels.values.length > 0)

            implicitWidth: 30 + activeWindowContainer.implicitWidth
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
                    // padding

                    radius: 4
                    color: workspace_button.modelData.focused ? "#476894" : "#3B3542"
                    // color: "transparent"
                    width: 26
                    height: 26

                    RectangularShadow {
                        offset: Qt.vector2d(-5.0, -5.0)
                        width: 30
                        height: 8
                        blur: 1
                        color: "#1A1A1A"
                        opacity: 0.5
                        // spread: 10
                    }
                    Text {
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: 1
                        text: workspace_button.modelData.name
                        // padding: 8
                        color: workspace_button.modelData.focused ? "#FFFFFF" : "#A5ACB5"

                        font {
                            pixelSize: 14
                            family: "RZPix"
                            bold: true
                        }

                        // anchors.: 8

                    }
                }
                Image {
                    id: select
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    // onBaselineOffsetChanged
                    // x: 20
                    // y: 20
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
                    // anchors.fill: parent
                    source: "selection.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: workspace_button.modelData.activate()
                    cursorShape: Qt.PointingHandCursor
                }
            }
            Rectangle {
                id: activeWindowContainer
                property real expandedWidth: activeWindowText.width + 20
                visible: workspace_button.shouldNameBeVisible
                implicitWidth: 0

                implicitHeight: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                x: 29
                z: -1
                color: "#494A5B"
                radius: 4

                states: State {
                    // name: "shown"
                    when: workspace_button.shouldNameBeVisible
                    PropertyChanges {
                        target: activeWindowContainer
                        implicitWidth: expandedWidth
                        visible: workspace_button.shouldNameBeVisible
                    }
                }

                transitions: Transition {
                    // SequentialAnimation {
                    // PropertyAnimation {
                    //     target: activeWindowContainer
                    //     property: "visible"
                    //     duration: 0
                    // }
                    PropertyAnimation {
                        target: activeWindowContainer
                        property: "implicitWidth"
                        duration: 200
                        easing.type: Easing.OutBack
                    }
                    // }
                }

                // Component.onCompleted: workspace_button.modelData.focusedChanged.connect(name_anim.start)
                // PropertyAnimation {
                //     id: name_anim
                //     target: activeWindowContainer
                //     properties: "implicitWidth"
                //     from: workspace_button.modelData.focused ? 0 : activeWindowContainer.expandedWidth
                //     to: workspace_button.modelData.focused ? activeWindowContainer.expandedWidth : 0
                //     duration: 200
                //     easing.type: Easing.OutBack
                // }

                Rectangle {
                    anchors.leftMargin: 0
                    anchors.margins: 3
                    anchors.fill: parent

                    color: "#343A4D"

                    Text {
                        id: activeWindowText
                        anchors.centerIn: parent
                        text: workspaces.activeWindowName
                        color: "#A5ACB5"
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

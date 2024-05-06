import QtQuick
import QtQuick.Controls

ToolBar {
    id: toolBar

    property alias titleText: title.text
    property alias backButton: backButton
    property alias acceptButton: acceptButton
    property alias previousPageTitle: backButton.text
    property alias acceptButtonVisible: acceptButton.visible

    ToolButton {
        id: backButton
        anchors.left: parent.left
        anchors.leftMargin: 5
        icon.source: "qrc:/mykitchen/images/LeftArrow_Icon_Dark.svg"
        text: qsTr("Tasks")

        palette.button: "#34C759"
        palette.highlight: "#248A3D"
    }

    Label {
        id: title
        text: qsTr("Settings")
        font.pixelSize: appSettings.fontSize + 4
        horizontalAlignment: Text.AlignHCenter
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    ToolButton {
        id: acceptButton

        anchors.right: parent.right
        anchors.rightMargin: 5
        visible: false
        //icon.source: "images/Check_Icon.svg"

        palette.button: "#34C759"
        palette.highlight: "#248A3D"
    }
}

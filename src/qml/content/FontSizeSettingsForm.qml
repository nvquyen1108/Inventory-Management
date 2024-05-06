import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "qrc:/mykitchen/src/qml/setting"

Page {
    id: root

    property alias backButton: navBar.backButton
    padding: 12


    header: NavBar{
        id: navBar

        titleText: qsTr("Font Size") + appSettings.fontSize
        previousPageTitle: qsTr("Settings")
        acceptButton.visible: false
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 20

        spacing: 12

        Label {
            text: qsTr("A")
            font.pixelSize: 10
            font.weight: 400
        }

        Slider {
            id: slider

            Layout.fillWidth: true

            snapMode: Slider.SnapAlways
            stepSize: 1
            from: 10
            value: appSettings.fontSize
            to: 48

            onMoved: appSettings.fontSize = value
        }

        Label {
            text: qsTr("A")
            font.pixelSize: 48
            font.weight: 400
        }
    }    
}

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"
import Suplier.App
Rectangle{
    id: items
    property alias titleText: titleText
    property alias mouseText: mouseText

    Rectangle{
        anchors.fill: parent
        clip: true
        color: "transparent"
        ColumnLayout{
            anchors.fill: parent
            Rectangle{
                id:suplierTitle
                Layout.fillHeight: true
                Layout.preferredHeight: 100
                Text {
                    id: titleText
                    text: "Inventory Overview"
                    font.pointSize: appSettings.fontSize + 14//24
                    font.weight : Font.DemiBold
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    MouseArea{
                        id:mouseText
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            this.cursorShape = Qt.PointingHandCursor
                        }
                    }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "gray"
            }
        }
    }
}


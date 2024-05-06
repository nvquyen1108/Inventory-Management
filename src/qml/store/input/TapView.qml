import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"
import Suplier.App


FocusScope {
    id: menu
    property alias titleText: inputTitleText.text
    Rectangle{
        anchors.fill: parent
        clip: true
        color: "transparent"
        ColumnLayout{
            anchors.fill: parent
            Rectangle{
                id:inputTitle
                Layout.fillHeight: true
                Layout.preferredHeight: 100
                Text {
                    id: inputTitleText
                    text: "Input"
                    font.pointSize: 24
                    font.weight : Font.DemiBold
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            this.cursorShape = Qt.PointingHandCursor
                        }
                        onClicked: {
                            inputTitleText.text = "Input"
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


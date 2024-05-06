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

//    required property Item keyDownTarget
    property alias titleText: suplierTitleText.text
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
                    id: suplierTitleText
                    text: "Supplier"
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
                            suplierTitleText.text = "Supplier"
                            gridMenu.gridview.currentIndex = -1
                            root.creatingNewEntry = false
                            root.editingEntry = false
                            suplierTitle.forceActiveFocus();
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


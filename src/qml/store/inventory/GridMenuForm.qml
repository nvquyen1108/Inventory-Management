import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Controls.Material

Rectangle {
    id: menu

    property alias gridview: appsGrid

    Rectangle {
        anchors.fill: parent
        clip: true
        color: "white"
        anchors.margins: 10
        ListModel{
            id: listModel
//            ListElement{
//                type: "pageLocation"
//                name: "Địa điểm kho"
//                pageUrl: "qrc:/mykitchen/src/qml/store/inventory/PageLocation.qml"
//                avisible: true
//            }
            ListElement{
                type: "pageProduct"
                name: "Vật tư"
                pageUrl: "qrc:/mykitchen/src/qml/store/inventory/PageProduct.qml"
                avisible: true
            }
            ListElement{
                type: "pageInventory"
                name: "Tồn kho"
                pageUrl: "qrc:/mykitchen/src/qml/store/inventory/PageInventory.qml"
                avisible: true
            }
//            ListElement{
//                type: "pageInput"
//                name: "Nhập hàng"
//                pageUrl: "qrc:/mykitchen/src/qml/store/inventory/PageInput.qml"
//                avisible: true
//            }
//            ListElement{
//                type: "pageOutput"
//                name: "Xuất hàng"
//                pageUrl: "qrc:/mykitchen/src/qml/store/inventory/PageOutput.qml"
//                avisible: true
//            }
//            ListElement {
//                type: "pageUnit"
//                name: "Đơn vị đo"
//                pageUrl: "qrc:/mykitchen/src/qml/store/unit/PageUnit.qml"
//                avisible: false
//            }
        }
        GridView {
            id: appsGrid
            anchors.fill: parent
            model: listModel
            cellWidth: parent.width/4
            cellHeight: this.cellWidth/2
            currentIndex: -1
            boundsBehavior: Flickable.StopAtBounds

            delegate: Rectangle {
                id: container
                width: appsGrid.cellWidth
                height: appsGrid.cellHeight
                Rectangle {
                    id: content
                    anchors.fill: parent
                    width: parent.width/1.2
                    height: parent.height/1.5
                    anchors.margins: 20
                    color: "#91AA9D"
                    Rectangle{
                        id: rectEnter
                        anchors.fill: parent
                        anchors.margins: 3
                        Label{
                            x: 10
                            text: name
                            font.bold: true
                            font.pointSize : 24
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                            wrapMode: Text.WordWrap

                        }
                    }
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        rectEnter.color = "lightsteelblue"
                    }
                    onExited: {
                        rectEnter.color = "white"
                    }

                    onClicked: {
                        appsGrid.currentIndex = index

                        tabMenu.titleText.text = tabMenu.titleText.text + "/" + name
                        getType(type)
                        mainContain.visible = true
                        gridMenu.visible = false
                    }
                }
                transitions: Transition {
                    NumberAnimation {
                        properties: "scale"
                        duration: 100
                    }
                }
                Dialog {
                    id: messDialog
                    visible: false
                    focus: true
                    modal: true
                    title: qsTr("Remove Contact")
                    standardButtons: Dialog.Cancel | Dialog.Ok

                    onAccepted: appsGrid.model.remove(appsGrid.currentIndex,displayName);
                }
            }
        }
    }
}

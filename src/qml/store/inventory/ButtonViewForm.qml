import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Controls.Material

FocusScope {
    id: menu
    Rectangle{
        anchors.fill: parent
        clip: true
        color: "transparent"
        RowLayout{
            RoundButton {
                id: addButton
                text: qsTr("Add")
                highlighted: true
                activeFocusOnTab: true
                focus: true
                onClicked: {
                    addText.visible = true
                    infoText.visible = false
                    recTable.visible = true
                    pageProduct.creatingNewEntry = true
                    pageProduct.editEntry = false
                    pageProduct.rowSelect = -1
                    console.log("suplier.qml clicked Add...")
                    addButton.forceActiveFocus();
                }
            }
            RoundButton {
                id: saveButton
                text: qsTr("Save")
                highlighted: true
                enabled: pageProduct.creatingNewEntry || pageProduct.editEntry && pageProduct.rowSelect !== -1
                onClicked: {
                    console.log("suplier.qml clicked Save")
                    saveButton.forceActiveFocus();                

                    if(pageProduct.rowSelect >= 0){
                        if(myProductList.updateData(pageProduct.rowSelect, infoText.eIdObject, infoText.eProductsName, infoText.eUnitName, infoText.eSupplierName, infoText.eQrCode, infoText.eBarCode, infoText.eNote, infoText.eImageFile)){
                            myProductModel.refresh();
                        }else{
                            mDialog.title = "Tên nhà cung cấp và đơn vị đo \nkhông hợp lệ hoặc không có sẵn"
                            mDialog.visible = true
                        }
                    }else{
                        if(addText.tProductsName === ""){
                            mDialog.visible = true
                        }else if(myUnitModel.append(addText.tUnitName)){
                            saveImages.save_images(addText.tImageFile,"C:/Users/ProTech/Desktop/kitchen/mykitchen/profile")
//                            saveImages.saveImageToDatabase(addText.tImageFile)
                            myProductModel.append(addText.tProductsName,addText.tUnitName,addText.tSupplierName,addText.tQrCode,addText.tBarCode,addText.tNote,addText.tImageFile)
                            myProductList.refresh();
                            addText.initRect();
                            pageProduct.creatingNewEntry = true
                        }else{
                            mDialog.title = "Tên nhà cung cấp và đơn vị đo \nkhông hợp lệ hoặc không có sẵn"
                            mDialog.visible = true
                        }
                    }
                }
                Dialog {
                    id: mDialog
                    visible: false
                    focus: true
                    modal: true
                    title: qsTr("Bạn chưa nhập thông tin")
                    standardButtons: Dialog.Cancel
                }
            }
            Label {
                id: labelBack
                text: qsTr("Sản phẩm")
                color: "steelblue"
                font.weight : Font.DemiBold
                font.pixelSize: appSettings.fontSize + 14
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                        labelBack.color = "lightsteelblue"
                    }
                    onExited: {
                        labelBack.color = "steelblue"
                    }
                    onClicked: {
                        labelBack.forceActiveFocus()
                        addText.visible = false
                        recTable.visible = true
                        pageProduct.creatingNewEntry = false
                        pageProduct.editEntry = false
                        pageProduct.rowSelect = -1
                    }
                }
            }
            Image {
                id: setup
                width: 100
                height: 40
                visible: !pageProduct.creatingNewEntry && pageProduct.editEntry && pageProduct.rowSelect !== -1
                anchors.centerIn: parent.Center
                source: "qrc:/mykitchen/images/settings.png"
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                    }
                    onClicked: {
                        popSetup.visible = !popSetup.visible
                    }
                    Popup {
                        id:popSetup
                        visible: false
                        y: setup.height
                        implicitWidth: 100
                        implicitHeight: 40
                        topPadding: 0
                        bottomPadding: 0
                        contentItem: Item{
                            implicitWidth: parent.width
                            implicitHeight: popSetup.height
                            Rectangle{
                                width: parent.width
                                height: parent.height
                                Row {
                                    anchors.fill: parent
                                    Image {
                                        id: im
                                        anchors.verticalCenter: parent.verticalCenter
                                        source: "qrc:/mykitchen/images/remove.png"
                                    }
                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        clip: true
                                        text: "delete"
                                    }
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
                                    }
                                    onExited: {
                                    }
                                    onClicked: {
                                        console.log("clicked remove")
                                        myProductModel.remove(pageProduct.rowSelect,pageProduct.mIdObject);
                                        myProductList.refresh();
                                        infoText.visible = false
                                        recTable.visible = true
                                        pageProduct.rowSelect = -1
                                        popSetup.visible = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

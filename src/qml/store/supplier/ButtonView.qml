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

                    tabMenu.titleText = "Supplier/Add New"
                    addMenu.initRect();
                    root.creatingNewEntry = true
                    root.editingEntry = false
                    gridMenu.gridview.currentIndex = -1
                    console.log("suplier.qml clicked Add...")
                    addButton.forceActiveFocus();
                }
            }
            RoundButton {
                id: editButton
                text: qsTr("Edit")
                highlighted: true
                enabled: !root.creatingNewEntry && !root.editingEntry && gridMenu.gridview.currentIndex !== -1
                activeFocusOnTab: true
                focus: true
                onClicked: {

                    tabMenu.titleText = "Supplier/Edit"
                    root.editingEntry = true
                    //addMenu.initRect();
                    console.log("suplier.qml clicked Edit...")
                    addMenu.editContact(mySuplierList.get(gridMenu.gridview.currentIndex))
                    addButton.forceActiveFocus();
                }
            }
            RoundButton {
                id: saveButton
                text: qsTr("Save")
                highlighted: true
                enabled: root.creatingNewEntry || root.editingEntry && gridMenu.gridview.currentIndex !== -1
                onClicked: {
                    console.log("suplier.qml clicked Save")
                    saveButton.forceActiveFocus();
                    if(gridMenu.gridview.currentIndex >= 0){
                        mySuplierList.updateData(gridMenu.gridview.currentIndex,addMenu.sdisplayname, addMenu.saddress, addMenu.semail, addMenu.sphone, addMenu.smoreInfo, addMenu.slogoFile);
                    }else{
                        if(addMenu.sdisplayname === "" && addMenu.saddress === "" && addMenu.semail === "" && addMenu.sphone === "" && addMenu.smoreInfo === ""){
                            mDialog.visible = true
                        }else if(mySuplierList.append(addMenu.sdisplayname, addMenu.saddress, addMenu.semail, addMenu.sphone, addMenu.smoreInfo, addMenu.slogoFile)){
                            addMenu.initRect()
                            root.creatingNewEntry = true
                            root.editingEntry = false
                        }else {
                            mDialog.visible = true
                            mDialog.title = "Thông tin bạn nhập chưa chính xác. vui lòng kiểm tra lại"
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
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
            }
        }
    }
}

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
                id: saveButton
                text: qsTr("Save")
                highlighted: true
                onClicked: {
                    for(var i = 0; i < contactView.product_infomation_array.length; i++){
                        if(myUnitModel.append(contactView.product_infomation_array[i].unitTypeComboBox.contentItem.text)){
                            if(inputList.append(contactView.product_infomation_array[i].idType.text,contactView.product_infomation_array[i].numberType.text,contactView.product_infomation_array[i].inputPriceType.text,contactView.product_infomation_array[i].noteType.text,addMenu.imageFile)){
                                contactView.product_infomation_array[i].initCreate()
                                addMenu.initCreate()
                            }

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

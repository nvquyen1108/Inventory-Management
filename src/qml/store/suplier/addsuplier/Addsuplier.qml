import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"
import Macai.App
import Custom
import Suplier.App
import Suplier.Add

Item {
//    property alias mainSuplierInfo: mainSuplierInfo
//    property alias rectTextField: rectTextField

    property string sdisplayname: fullName.text
    property string saddress: address.text
    property string semail: email.text
    property string sphone: phone.text
    property string smoreInfo: moreInfo.text
    property string slogoFile: logoFile.selectedFile
    property bool textFieldChecked: false

    function initRect(){
        fullName.clear();
        address.clear();
        email.clear();
        phone.clear();
        moreInfo.clear();
        imageLogo.source = "qrc:/mykitchen/images/upload-icon.png";
    }

//    property alias mySuplierModel: mySuplierModel

    property int boxWidth: 240
    property int boxHeight: 40
    property int checkboxLeftPading: 60

//    SqlSuplierModel{
//        id: mySuplierModel
//    }
//    SqlSuplierList{
//        id: mySuplierList
//    }

//    ColumnLayout{
//        id: mainAddSuplier

//        anchors.fill: parent
//        spacing: 0
//        Rectangle {
//            Layout.fillWidth: true
//            Layout.leftMargin: 20
//            Layout.bottomMargin: 5
//            Layout.preferredHeight: 55
//            color: "transparent"
//            RowLayout{
//                anchors.fill: parent
//                RoundButton {
//                    text: qsTr("Save")
//                    highlighted: true
//                    onClicked: {
//                        if(fullName.text === "" && address.text === "" && email.text === "" && phone.text === "" && moreInfo.text === "" && logoFile.selectedFile === ""){
//                            messDialog.visible = true
//                        }else{
//                            mySuplierList.append(fullName.text, address.text, email.text, phone.text, moreInfo.text, logoFile.selectedFile);
//                            fullName.text = "";
//                            address.text = "";
//                            email.text = "";
//                            phone.text = "";
//                            moreInfo.text = "";
//                            imageLogo.source = "qrc:/mykitchen/images/upload-icon.png";
//                            console.log(fullName.text + address.text+ email.text+ phone.text+ moreInfo.text+ logoFile.selectedFile)
////                            mySuplierList.set(currentContact,fullName.text, address.text, email.text, phone.text,moreInfo.text)
//                        }
//                    }
//                    Dialog {
//                        id: messDialog
//                        visible: false
//                        focus: true
//                        modal: true
//                        title: qsTr("Bạn chưa nhập đúng thông tin")
//                        standardButtons: Dialog.Cancel
//                    }
//                }
//                Rectangle{
//                    Layout.fillWidth: true
//                    Layout.fillHeight: true
//                    color: "transparent"
//                }
//            }
//        }
        Rectangle{
            id: rectTextField
            Layout.fillWidth: true
            Layout.preferredHeight: 300
            RowLayout{
                spacing: 50
                ColumnLayout {
                    id: columnLogo
                    Label {
                        Layout.leftMargin: 60
                        text: qsTr("Logo nhà cung cấp")
                        font.weight : Font.DemiBold
                        font.pixelSize: 24
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }
                    Rectangle {
                        id: logoSuplier
                        Layout.preferredWidth: boxWidth
                        height: boxWidth
                        Layout.leftMargin: 60
                        radius: 5
                        DashRect{
                            id: dashRect
                            width: logoSuplier.width
                            height: this.width
                            FileDialog {
                                id: logoFile
                                currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                                onAccepted: {
                                    imageLogo.source = selectedFile
                                    imageLogo.width = dashRect.width - 10
                                    imageLogo.height = this.width
                                }
                            }
                            Image {
                                id: imageLogo
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                source: "qrc:/mykitchen/images/upload-icon.png"
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    this.cursorShape = Qt.PointingHandCursor
                                }
                                onClicked: {
                                    onTriggered:  logoFile.open()
                                }
                            }
                        }
                    }
                }
                GridLayout {
                    id: grid
                    visible: true
                    property int minimumInputSize: 120

                    rows: 4
                    columns: 4
                    rowSpacing: 20
                    columnSpacing: 10
                    Label {
                        text: qsTr("Tên nhà cung cấp: ")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: fullName
                        property string oldString
                        focus: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        onFocusChanged: if (focus) oldString = fullName.text

                        placeholderText: qsTr("Full Name")
                    }

                    Label {
                        text: qsTr("Email: ")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: email
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("abc@xyz.com")
                    }
                    Label {
                        text: qsTr("Address: ")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: address
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("Address")
                    }
                    Label {
                        text: qsTr("Điện thoại: ")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: phone
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("Phone Number")
                    }

                    Label {
                        text: qsTr("Thông tin thêm: ")
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: moreInfo
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("More Info")
                    }
                }
            }
        }
//        Rectangle {
//            id: mainContainn
//            visible: true
//            color: "transparent"
//            Layout.fillWidth: true
//            Layout.fillHeight: true
//            Rectangle {
//                width: parent.width
//                height: parent.height
//                color: "transparent"
//                Loader {
//                    anchors.fill: parent
//                    id: mainContainLoaderr
//                }
//            }
//        }
//    }
}

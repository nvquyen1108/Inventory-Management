import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtQuick.Controls.Material
import Suplier.App
import Macai.App
import Suplier.Add
import "qrc:/mykitchen/src/qml/store/suplier/contactlist"
import "qrc:/mykitchen/src/qml/setting"
import "qrc:/mykitchen/src/qml/store/suplier/addsuplier"

Rectangle {
    id: root
    anchors.fill:parent
    color: "#f5f5f5"
    SqlSuplierList{
        id: mySuplierList
    }
    property string mdisplayname: ""
    property string maddress: ""
    property string memail: ""
    property string mphone: ""
    property string mmoreInfo: ""
    property string mcontractDate: ""
    property string mlogoFile: ""
    property int fontsizes: appSettings.fontSize

    AppSettings{
        id: appSettings
    }

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            id: suplierTitle
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "transparent"
            Text {
                id: suplierTitleText
                text: "Supplier"
                font.pointSize: 24
                font.weight : Font.DemiBold
                // anchors.verticalCenter: parent.verticalCenter
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
                            mainAdd.visible = false
                            mainInfo.visible = false
                            rectGrids.visible = true
                            //mainContainLoader.source = "qrc:/mykitchen/src/qml/store/suplier/suplier.qml"
                    }
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: "gray"
                anchors.bottom: parent.bottom
            }
        }
        Rectangle {
            id: formAdd
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.preferredHeight: 50
            color: "transparent"
            Rectangle{
                width: parent.width
                height: parent.height
                RowLayout{
                    anchors.fill: parent
                    RoundButton {
                        text: qsTr("Add")
                        highlighted: true
                        onClicked: {
                            addForm.initRect();
                            suplierTitleText.text = "Supplier/Add New"
                            console.log("suplier.qml clicked Add...")
                            mainAdd.visible = true
                            mainInfo.visible = false
                        }
                    }
                    RoundButton {
                        text: qsTr("Save")
                        highlighted: true
                        onClicked: {
                            console.log("suplier.qml clicked Save")
                            if(addForm.sdisplayname === "" && addForm.saddress === "" && addForm.semail === "" && addForm.sphone === "" && addForm.smoreInfo === ""){
                                mDialog.visible = true
                            }else{
                                mySuplierList.append(addForm.sdisplayname, addForm.saddress, addForm.semail, addForm.sphone, addForm.smoreInfo, addForm.slogoFile);
                                addForm.initRect()
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
        Rectangle {
            id: mainAdd
            visible: false
            color: "red"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
                Addsuplier {
                    anchors.fill: parent
                    id: addForm
                }
            }
        }
        Rectangle {
            id: mainInfo
            visible: false
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
                Suplierinfo{
                    anchors.fill: parent
                    id: infoForm
                }
            }
        }
        Rectangle {
            id: rectGrids
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Rectangle {
                id: applist
//                y: 150
                width: parent.width
                height: parent.height
//                anchors {
//                    bottom: parent.bottom
//                    topMargin: 200
//                }
                color: "transparent"
                GridView {
                    id: appsGrid
                    anchors.fill: parent
                    model: mySuplierList
                    cellWidth: parent.width/4
                    cellHeight: this.cellWidth/2
                    currentIndex: -1
                    delegate: Rectangle {
                        width: appsGrid.cellWidth
                        height: appsGrid.cellHeight
                        color: "transparent"
                        Rectangle{
                            id: rectApps
                            width: parent.width/1.2
                            height: parent.height/1.5
                            radius: 10
                            color: "white"

//                            color: Qt.rgba(128/255, 128/255, 128/255, 0.5)
                            anchors {
                                centerIn: parent
                            }
                            RowLayout {
                                anchors.fill: parent
                                spacing: 10
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 1
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Image {
                                        id: appImages
                                        width: parent.width
                                        height: this.width
                                        source: logoFile
                                        fillMode: Image.PreserveAspectFit
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                Rectangle{
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 2
                                    Layout.fillHeight: true
                                    color: "transparent"
                                    Column{
                                        id: appNames
                                        anchors.centerIn: parent
                                        spacing: 5
                                        Label {
                                            text: displayName
                                            font.bold: true
                                            font.pixelSize: fontsizes + 6
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                            wrapMode: Text.WordWrap
                                        }
                                        Label {
                                            id: addressLabel
                                            text: address
                                            Layout.fillWidth: true
                                            wrapMode: Text.WordWrap
                                        }
                                        Label {
                                            text: phone
                                            Layout.fillWidth: true
                                            wrapMode: Text.WordWrap
                                        }
                                        Label {
                                            text: email
                                            Layout.fillWidth: true
                                            wrapMode: Text.WordWrap
                                        }
                                        states: [
                                            State {
                                                when: addressLabel.text.length > 20
                                                PropertyChanges {
                                                    target: addressLabel
                                                    width: (rectApps.width*2)/4
                                                    height: rectApps.paintedHeight
                                                }
                                            },
                                            State {
                                                when: addressLabel.text.length <= 20
                                                PropertyChanges {
                                                    target: addressLabel
                                                    width: (rectApps.width*2)/4
                                                    height: rectApps.paintedHeight
                                                }
                                            }
                                        ]
                                    }
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
//                                    this.cursorShape = Qt.PointingHandCursor
                                    rectApps.color = "lightsteelblue"
                                    rectApps.width += 30
                                    rectApps.height += 30
                                }
                                onExited: {
                                    rectApps.width -= 30
                                    rectApps.height -= 30
                                    rectApps.color = "white"
                                }
                                onClicked: {
                                    suplierTitleText.text = "Supplier/Infomation"
                                    mainAdd.visible = false
                                    mainInfo.visible = true
                                    mdisplayname = displayName;
                                    maddress = address;
                                    memail = email;
                                    mphone = phone;
                                    mmoreInfo = moreinfo;
                                    mcontractDate = contractDate;
                                    mlogoFile = logoFile;
                                    appsGrid.currentIndex = index
//                                    console.log("Item at index 0:", appsGrid.model.get(appsGrid.currentIndex).displayName);
//                                    console.log("Item at index 1:", appsGrid.currentIndex);
                                }
                                Rectangle{
                                    id: removeContact
                                    width: 30
                                    height: this.width
                                    Text {
                                        text: qsTr("X")
                                        anchors.centerIn: parent
                                    }
                                    anchors{
                                        top: parent.top
                                        right: parent.right
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            this.cursorShape = Qt.PointingHandCursor
                                        }
                                        onClicked: (mouse) => {
                                            appsGrid.currentIndex = index
                                            messDialog.visible = true
                                            mouse.accepted = true
                                        }
                                    }
                                }
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
    }
}

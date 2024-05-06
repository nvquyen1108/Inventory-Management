import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtCore

Dialog {
    id: dialog

    signal finished(string fullName, string email, string address, string phone, string moreInfo, string logoFile)

    function createContact() {
        fullName.clear();
        address.clear();
        email.clear();
        phone.clear();
        moreInfo.clear();
        imageLogo.source = "qrc:/mykitchen/images/upload-icon.png"

        dialog.title = qsTr("Add Contact");
        dialog.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    title: qsTr("Add Contact")
    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: Rectangle {
        anchors.fill: parent
        clip: true
        color: "white"
        radius: 5
        RowLayout{
            anchors.fill: parent
            spacing: 50
            ColumnLayout {
                id: columnLogo

                Label {
                    Layout.leftMargin: 60
                    text: qsTr("Logo nhà cung cấp")
                    font.weight : Font.DemiBold
                    font.pixelSize: 24
                }
                Rectangle{
                    id: dashRect
                    width: 250
                    height: this.width
                    Layout.leftMargin: 60
                    //color : "lightsteelblue"
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
                        width: dashRect.width
                        height: this.width
                        scale: 0.8
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
            GridLayout {
                id: grid
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
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 40
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
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 40
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
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 40
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
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 40
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
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    placeholderText: qsTr("More Info")
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 100
            }
        }
    }

    onAccepted: finished(fullName.text, email.text, address.text, phone.text, moreInfo.text, logoFile.selectedFile)
}

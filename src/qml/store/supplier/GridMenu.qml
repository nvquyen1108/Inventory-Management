import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Controls.Material

FocusScope {
    id: menu

    property alias gridview: appsGrid
    property string idisplayname: ""
    property string iaddress: ""
    property string iemail: ""
    property string iphone: ""
    property string imoreInfo: ""
    property string icontractDate: ""
    property string ilogoFile: ""
    function getListInfo(contact){
        idisplayname = contact.displayName;
        iaddress = contact.address;
        iemail = contact.email;
        iphone = contact.phone;
        imoreInfo = contact.moreinfo;
        icontractDate = contact.contractdate;
        ilogoFile = contact.logoFile;
    }

    Rectangle {
        anchors.fill: parent
        clip: true
        color: "transparent"
        GridView {
            id: appsGrid
            anchors.fill: parent
            model: mySuplierList
            cellWidth: parent.width/4
            cellHeight: this.cellWidth/2
            currentIndex: -1
            boundsBehavior: Flickable.StopAtBounds

            delegate: Rectangle {
                width: appsGrid.cellWidth
                height: appsGrid.cellHeight
                color: "transparent"
                Rectangle{
                    id: rectApps
                    width: parent.width/1.2
                    height: parent.height/1.5
//                    radius: 10
                    color: "#91AA9D"
                    anchors.centerIn: parent
                    Rectangle{
                        id: rectEnter
//                        color: "transparent"
                        anchors.fill: parent
                        anchors.margins: 3

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
                                        font.pointSize: fontsizes + 6
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                    Label {
                                        id: addressLabel
                                        text: address
                                        font.pointSize: fontsizes
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                    Label {
                                        text: phone
                                        font.pointSize: fontsizes
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                    Label {
                                        text: email
                                        font.pointSize: fontsizes
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
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectEnter.color = "lightsteelblue"
                        }
                        onExited: {
                            rectEnter.color = "white"
                        }
                        onClicked: {
                            tabMenu.titleText = "Supplier/Infomation"
                            getListInfo(appsGrid.model.get(index))
                            appsGrid.currentIndex = index
                            creatingNewEntry = false
                            editingEntry = false
                            myProductModel.getName(idisplayname)
                            appsGrid.forceActiveFocus();
                        }
                        Rectangle{
                            id: removeContact
                            width: 30
                            height: this.width
                            anchors.margins: 3
                            Text {
                                text: qsTr("X")
                                anchors.centerIn: parent
                                font.pointSize: appSettings.fontSize + 2
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
                    transitions: Transition {
                        NumberAnimation {
                            properties: "scale"
                            duration: 100
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

                    onAccepted: appsGrid.model.remove(appsGrid.currentIndex,email);
                }
            }
        }
    }
}

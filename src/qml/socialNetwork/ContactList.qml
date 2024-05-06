import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

Rectangle {
    color: "transparent"
    id: root
    Rectangle {
        id: headerContact
        height: 60
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "mediumblue"
        RowLayout {                                
            width: parent.width
            height: parent.height      
            anchors.fill: parent.fill
            Image {
                Layout.preferredWidth: parent.width*0.15
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: 3
                Layout.bottomMargin: 3
                Layout.leftMargin: 10
                source: "../../../images/search.png"
                fillMode: Image.PreserveAspectFit
            }                                
            TextField {                                    
                Layout.preferredWidth: parent.width*0.73
                Layout.rightMargin: 5

                font.pointSize: 10
                placeholderText: qsTr("Tìm trong danh bạ")
                placeholderTextColor: "white"
                color: "white"

                selectionColor:  "gray"
                
                background: Rectangle {
                    radius: 2
                    width: parent.width
                    height: parent.height
                    border.color: "red"
                    border.width: 0
                    color: "transparent"

                }
            }
            Image {
                Layout.preferredWidth: parent.width*0.12
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: 3
                Layout.bottomMargin: 3
                Layout.rightMargin: 10
                source: "../../../images/white-minus.png"
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                    }
                    onClicked: {
                        root.visible = false
                        boxContact.height = 50
                        contactText.visible = true
                    }
                }
            }                       
        }
    }
    Rectangle {
        height: parent.height - headerContact.height
        width: parent.width
        anchors.bottom: parent.bottom
        color: "white"
        ListModel {
            id: contactModel
            ListElement {
                userID: "ID1"
                status: true
                name: "Nguyen Van Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID2"
                status: false
                name: "Nguyễn Văn B"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID3"
                status: false
                name: "C"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID4"
                status: true
                name: "D"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID5"
                status: true
                name: "E"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID6"
                status: false
                name: "F"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID7"
                status: true
                name: "G"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID8"
                status: false
                name: "H"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID9"
                status: false
                name: "I"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID10"
                status: false
                name: "J"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID11"
                status: false
                name: "K"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID12"
                status: false
                name: "L"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID13"
                status: false
                name: "M"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
            ListElement {
                userID: "ID14"
                status: false
                name: "N"
                imageUrl: "qrc:/mykitchen/images/user.jpg"
            }
        }
        ScrollView {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            width: parent.width
            ListView {
                id: contactsListView
                anchors.fill: parent
                spacing: 18
                clip: true
                model: contactModel
                delegate: contactDelegate
                boundsBehavior: Flickable.StopAtBounds
            }
        }
        Component {
            id: contactDelegate
            Rectangle {
                height: 55
                width: contactsListView.width*0.95
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                radius: 6
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                        parent.color = "#D9D9D9"
                    }
                    onExited: {
                        parent.color = "transparent"
                    }
                    onClicked: {
                        var itemExists = false;
                        for (var i = 0; i < messModel.count; ++i) {
                            if (messModel.get(i).eleUserID === userID){
                                messModel.move(i,0,1)
                                itemExists = true;
                                break;
                            }
                        }
                        if(!itemExists){
                            for (var i = 0; i < hideMessModel.count; ++i) {
                                if (hideMessModel.get(i).eleUserID === userID){
                                    hideMessModel.remove(i)
                                    break;
                                }
                            }
                            if(messModel.count<3) {
                                messModel.insert(0,{eleUserID: userID, eleName: name, eleStatus: status, eleImageUrl: imageUrl})
                            } else {
                                if(hideMessModel.count > 6){
                                    hideMessModel.remove(hideMessModel.count-1)
                                }
                                hideMessModel.insert(0,messModel.get(messModel.count-1))
                                messModel.remove(messModel.count-1)
                                messModel.insert(0,{eleUserID: userID, eleName: name, eleStatus: status, eleImageUrl: imageUrl})
                            }
                        }                        
                    }
                }
                Image {
                    id: avatar
                    width: this.height
                    height: parent.height 
                    fillMode: Image.PreserveAspectCrop
                    source: imageUrl
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource : Rectangle {
                            anchors.centerIn: parent
                            width:avatar.width
                            height: avatar.height
                            radius: width / 2
                        }
                    }
                    scale: 0.7
                }
                Rectangle {
                    width: 12
                    height: 12
                    color: status ? "green" : "silver"
                    radius: width / 2
                    anchors.bottom: avatar.bottom
                    anchors.right: avatar.right
                    anchors.bottomMargin: avatar.height*0.15
                    anchors.rightMargin: avatar.width*0.15
                    border.color: "white"
                    border.width: 3
                } 
                Text {
                    id: contactName
                    width: parent.width-avatar.width
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: avatar.right
                    text: name
                    font.family: "Helvetica"
                    font.pointSize: 12
                    opacity: 0.9
                    elide: Text.ElideRight
                }
            }
        }

    }
}

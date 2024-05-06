import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

Rectangle {
    color: "white"
    radius: 5
    ListModel {
        id: chatHistory
        ListElement{
            sender: true
            message: "Hello"
        }
        ListElement{
            sender: true
            message: "Long time no see, How are you?"
            
        }
        ListElement{
            sender: false
            message: "I'm fine"
        }
        ListElement{
            sender: true
            message: "Hello"
        }
        ListElement{
            sender: true
            message: "Long time no see, How are you?"
            
        }
        ListElement{
            sender: false
            message: "I'm fine"
        }
        ListElement{
            sender: true
            message: "Hello"
        }
        ListElement{
            sender: true
            message: "Long time no see, How are you?"
            
        }
        ListElement{
            sender: false
            message: "I'm fine"
        }
    }
    Rectangle {
        id: header
        height: parent.height * 0.15
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 10
        color: "transparent"
        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            Rectangle {
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height
                Image {
                    id: avatar
                    width: parent.width 
                    height: parent.height 
                    fillMode: Image.PreserveAspectCrop
                    source: eleImageUrl
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource : Item {
                            width: avatar.width
                            height: avatar.height
                            Rectangle {
                                anchors.centerIn: parent
                                width:parent.width
                                height: parent.height
                                radius: width / 2
                            }
                        }
                    }
                }
                Rectangle {
                    width: 10
                    height: 10
                    color: eleStatus ? "green" : "silver"
                    radius: width / 2
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    border.color: "white"
                    border.width: 3
                }
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width
                Layout.alignment: Qt.AlignVCenter
                spacing: -2
                Text {
                    id: persname
                    text: eleName
                    font.family: "Helvetica"
                    font.pointSize: 12
                    opacity: 0.8
                    Layout.fillHeight: true;
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
                Text {
                    Layout.fillHeight: true;
                    Layout.fillWidth: true
                    text: eleStatus ? "Online" : "Offline"
                    font.family: "Helvetica"
                    font.pointSize: 10
                    color: "black"
                    opacity: 0.8
                }
            }
            Image {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height
                source: "../../../../images/minimize.png"
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                    }
                    onClicked: {
                        if(hideMessModel.count > 6){
                            hideMessModel.remove(hideMessModel.count-1)
                        }
                        hideMessModel.insert(0,messModel.get(index))
                        messModel.remove(index)
                    }
                }
            }
            Image {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height
                source: "../../../../images/phone.png"
                fillMode: Image.PreserveAspectFit
                scale: 0.6
            }
            Image {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.height
                source: "../../../../images/delete.png"
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                    }
                    onClicked: {
                        messModel.remove(index)
                    }
                }
            }
        }
    }
    Rectangle {
        anchors.top: header.bottom 
        width: parent.width
        height: 1
        color: "black"
        opacity: 0.1
    }
    Rectangle {
        id: chatList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: chatInput.top
        anchors.top: header.bottom
        anchors.margins: 5
        ScrollView {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            width: parent.width
            height: parent.height
            ListView {
                id: viewchatList
                anchors.fill: parent
                width: parent.width
                height: parent.height
                spacing: 15
                model: chatHistory
                delegate: chatHistoryDelegate
                clip: true
                boundsBehavior: Flickable.StopAtBounds
            }
        }
        Component {
            id: chatHistoryDelegate
            Rectangle{
                height: messageText.implicitHeight + 24
                width: messageText.implicitWidth + 24
                // color: "blue"
                color: sender ? "blue" : "silver"
                x: sender ? viewchatList.width - width : 0
                radius: 5
                Text {
                    id: messageText
                    text: message
                    anchors.fill: parent
                    anchors.margins: 12
                    color: sender ? "white" : "black"
                    opacity: 0.8
                    font.pixelSize: 13
                    font.family: "Helvetica"
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: sender ? Qt.AlignLeft : Qt.AlignRight
                }
            }
        }
    }
    Rectangle {
        id: chatInput
        height: parent.height * 0.12
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "transparent"
        RowLayout {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8
            width: parent.width
            height: parent.height * 0.7
            spacing: 5
            ScrollView {
                Layout.preferredWidth: parent.width * 0.85
                Layout.fillHeight: true
                clip: true
                
                TextArea {
                    width: parent.width
                    height: parent.height
                    
                    verticalAlignment: Qt.AlignVCenter
                    placeholderText: qsTr("Type Message...")
                    font.family: "Heltiveca"
                    font.pointSize: 10
                    wrapMode: TextArea.Wrap
                    background: Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "silver"
                        radius: 15
                    }
                }
            }
            Image {
                Layout.preferredWidth: parent.width * 0.15 // 3 dong ts
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "../../../../images/send.png"
                fillMode: Image.PreserveAspectFit
                opacity: 0.8
                // anchors.centerIn: parent
                scale: 0.6
            }
        }
    }
}
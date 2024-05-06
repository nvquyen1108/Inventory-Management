import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

Rectangle {
    color: "blue"
    radius: this.width / 2
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
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                this.cursorShape = Qt.PointingHandCursor
                removeItemImage.visible = true
                textAvatarRect.visible = true
            }
            onExited: {
                removeItemImage.visible = false
                textAvatarRect.visible = false
            }
            onClicked: {
                messModel.insert(0,hideMessModel.get(index));
                if(messModel.count >= 4) {
                    hideMessModel.insert(0,messModel.get(messModel.count-1));
                    messModel.remove(messModel.count-1);
                }
                hideMessModel.remove(index);
            }
        }
    }
    Rectangle {
        width: 15
        height: 15
        color: eleStatus ? "green" : "silver"
        radius: width / 2
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        border.color: "white"
        border.width: 3
    }
    Image {
        id: removeItemImage
        visible: false
        width: 15
        height: 15
        fillMode: Image.PreserveAspectCrop
        source: "../../../../images/clear.png"
        anchors.right: parent.right
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource : Item {
                width: removeItemImage.width
                height: removeItemImage.height
                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width
                    height: parent.height
                    radius: width / 2
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                this.cursorShape = Qt.PointingHandCursor
            }
            onClicked: {
                hideMessModel.remove(index);
            }
        }
    }
    Rectangle {
        id: textAvatarRect
        visible: false
        width: textAvatar.implicitWidth + 10
        height: textAvatar.implicitHeight + 10
        anchors.right: parent.left
        anchors.margins: 8
        radius: 10
        Text {
            id: textAvatar
            anchors.centerIn: parent
            text: eleName
        }
    }
}
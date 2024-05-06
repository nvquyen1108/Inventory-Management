import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Suplier.Add
import "qrc:/mykitchen/src/qml/setting"

Rectangle {
    id: root
    anchors.fill:parent
//    color: "#f5f5f5"
    SqlSuplierList{
        id: mySuplierList
    }
    property int fontsizes: appSettings.fontSize
    property bool creatingNewEntry: false
    property bool editingEntry: false
    property alias tabMenu: tabMenu
    property alias gridMenu: gridMenu
    property alias mainContain: mainContain

    ColumnLayout{
        anchors.fill: parent
        TapView{
            id: tabMenu
            width: parent.width
            height: 100
        }
        Main{
            id: mainContain
            visible: false
            width: parent.width
            height: parent.height
        }
        GridMenu{
            id: gridMenu
            width: parent.width
            height: parent.height
        }
    }
}

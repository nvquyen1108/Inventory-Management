import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Suplier.Add
import Product.App
import "qrc:/mykitchen/src/qml/setting"

Rectangle {
    id: root
    anchors.fill:parent
    SqlSuplierList{
        id: mySuplierList
    }
    SqlProductModel{
        id: myProductModel
    }    property int fontsizes: appSettings.fontSize
    property bool creatingNewEntry: false
    property bool editingEntry: false
    property alias tabMenu: tabMenu

    FocusScope {
        id: mainView

        width: parent.width
        height: parent.height
        focus: true

        TapView {
            id: tabMenu
            width: parent.width
            height: 100

            focus: true
            activeFocusOnTab: true

            onActiveFocusChanged: {
                if (activeFocus)
                    mainView.state = "onTabViews"
            }
        }
        ButtonView{
            id: buttonView
            y: tabMenu.height
            width: parent.width
            height: 50
            focus: true
            activeFocusOnTab: true
            onActiveFocusChanged: {
                if (activeFocus)
                    mainView.state = "onButtonViews"
            }
        }
        AddView{
            id: addMenu
            visible: false
            y: 150
            width: parent.width
            height: 300
            focus: true
            activeFocusOnTab: true
        }

        Supplierinfo{
            id: infoMenu
            visible: false
            y: 150
            width: parent.width
            height: parent.height - 150
            focus: true
            activeFocusOnTab: true
        }
        GridMenu {
            id: gridMenu
            y: 150
            height: parent.height - 150
            width: parent.width
            activeFocusOnTab: true

            onActiveFocusChanged: {
                if (activeFocus)
                    mainView.state = "onGridViews"
            }
        }
        states:  [
            State {
                name: "onTabViews"
                PropertyChanges {
                    gridMenu.y: 150
                    gridMenu.height: parent.height - 150
                    infoMenu.visible: false
                    addMenu.visible: false
                }
            },
            State {
                name: "onGridViews"
                PropertyChanges {
                    gridMenu.visible: false
                    addMenu.visible: false
                    infoMenu.visible: true
                }
            },
            State {
                name: "onButtonViews"
                PropertyChanges {
                    gridMenu.y: 455
                    gridMenu.height: parent.height - 455
                    addMenu.y: 150
                    addMenu.visible: true
                    infoMenu.visible: false
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                properties: "y"
                duration: 600
                easing.type: Easing.OutQuint
            }
        }
    }
}

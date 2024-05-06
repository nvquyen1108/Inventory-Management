import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
//import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import Suplier.Add
import Product.App
import Product.List
import Unit.App
import Input.List

Rectangle {
    id: inputMenu
    anchors.fill:parent
    SqlSuplierList{
        id: mySupplierList
    }
    SqlProductModel{
        id: myProductModel
    }
    SqlProductList{
        id: myProductList
    }
    SqlUnitModel{
        id: myUnitModel
    }
    SqlInputList{
        id: inputList
    }
    property int fontsizes: appSettings.fontSize

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
        }
        ButtonView{
            id: buttonView
            y: tabMenu.height
            width: parent.width
            height: 50
            focus: true
            activeFocusOnTab: true
        }
        AddView{
            id: addMenu
            visible: true
            y: 150
            width: parent.width
            height: 250
            focus: true
            activeFocusOnTab: true
        }
        ContactView {
            id: contactView
            y: addMenu.height + tabMenu.height + buttonView.height
            width: parent.width
            height: parent.height - (addMenu.height + tabMenu.height + buttonView.height) + 10
        }
    }
}

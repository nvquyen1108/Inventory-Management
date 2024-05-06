import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Suplier.Add
import "qrc:/mykitchen/src/qml/setting"

StoreHomeForm {
    tabMenu.mouseText.onClicked : {
        tabMenu.titleText.text = "Inventory Overview"
        mainContain.mainLoader.source = ""
        gridMenu.visible = true
        mainContain.visible = false
    }
}

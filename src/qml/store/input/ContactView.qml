import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import QtQuick.Dialogs
import "qrc:/mykitchen/src/qml/components"
import Suplier.App

Item{
    id: stackView
    width: menu.width
    height: menu.height
    property int boxWidth: 239
    property int boxHeight: 40
    property int checkboxLeftPading: 60
    property int number: 0

    property var product_infomation_array: []

    property alias idType: product_infomation.idType
    property alias nameTypeComboBox: product_infomation.nameTypeComboBox
    property alias numberType: product_infomation.numberType
    property alias unitTypeComboBox: product_infomation.unitTypeComboBox
    property alias inputPriceType: product_infomation.inputPriceType
    property alias noteType: product_infomation.noteType

    Component.onCompleted: {
        product_infomation_array.push(product_infomation)
    }
    TabBar {
        id: addNewTabBar
        width: parent.width
        background: Rectangle {
            anchors.fill: parent
            color: "#F2F2F2"
        }
        TabButton {
            text: qsTr("Thông tin chung")
            onClicked: {
                addNewTabBar.currentIndex = TabBar.index;
            }
            horizontalPadding : 25
            verticalPadding: 12
            width: contentItem.implicitWidth + leftPadding + rightPadding
        }
        TabButton {
            text: qsTr("Thông tin khác")
            onClicked: {
                addNewTabBar.currentIndex = TabBar.index;
            }
            horizontalPadding : 25
            width: contentItem.implicitWidth + leftPadding + rightPadding
        }
    }
    StackLayout {
        id: stackAdd
        width: parent.width
        anchors.top: addNewTabBar.bottom
        anchors.bottom: footer.top
        currentIndex: addNewTabBar.currentIndex

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            Flickable {
                anchors.fill: parent
                width: parent.width
                height: parent.height
                contentWidth: productInputColumnLayout.implicitWidth;
                contentHeight: productInputColumnLayout.implicitHeight
                boundsBehavior: Flickable.StopAtBounds
                clip:true
                ScrollBar.vertical: ScrollBar {}
                ScrollBar.horizontal: ScrollBar {}
                Pane {
                    Material.background: "transparent"
                    ColumnLayout {
                        id: productInputColumnLayout
                        anchors.fill: parent
                        ColumnLayout {
                            id: productInfoListColumnLayout
                            ProductInfoList {
                                id: product_infomation
                            }
                        }
                        Button {
                            background: Image {
                                source:"qrc:/mykitchen/images/add.png"
                                fillMode: Image.PreserveAspectFit
                                width: 30
                            }
                            onClicked: {
                                var component = Qt.createComponent("qrc:/mykitchen/src/qml/store/input/ProductInfoList.qml");
                                var countProduct_infomation = component.createObject(productInfoListColumnLayout);

                                product_infomation_array.push(countProduct_infomation);
                            }
                        }
                    }
                }
            }
        }
    }
    Pane {
        id: footer
        anchors.bottom: parent.bottom
        Material.background: "#FAFAFA"
        width: parent.width
    }
}


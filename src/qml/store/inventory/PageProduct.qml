import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"
import Suplier.Add
import Product.App
import Product.List
import SaveImage.App
import Unit.App

Item{
    id:pageProduct
    SqlSuplierList{
        id: mySupplierList
    }
    SqlProductList{
        id: myProductList
    }
    SqlProductModel{
        id: myProductModel
    }
    SaveImages{
        id: saveImages
    }
    SqlUnitModel{
        id: myUnitModel
    }
    property string mIdObject: ""
    property string mProductsName: ""
    property string mQrCode: ""
    property string mUnitName: ""
    property string mBarCode: ""
    property string mSupplierName: ""
    property string mNote: ""
    property string mImageFile: ""

    property bool creatingNewEntry: false
    property bool editEntry: false
    property alias addText: addText
    property alias buttonMenu: buttonMenu
    property int rowSelect: -1
    function getData(productList){
        mIdObject = productList.id;
        mProductsName = productList.displayName;
        mUnitName = productList.idUnit;
        mSupplierName = productList.idSuplier;
        mQrCode = productList.qrCode;
        mBarCode = productList.barCode;
        mNote = productList.note;
        mImageFile = productList.imageFile;
    }


    FocusScope {
        id: mainView

        width: parent.width
        height: parent.height
        focus: true

        ButtonView{
            id: buttonMenu
            visible: true
            width: parent.width
            height: 50
            onActiveFocusChanged: {
                if (activeFocus)
                    mainView.state = "onButton"
            }
        }
        AddTextField{
            id: addText
            y: 50
            visible: false
            width: parent.width
            height: parent.height
        }
        InfoProduct{
            id: infoText
            y: 50
            visible: false
            width: parent.width
            height: parent.height - 160
        }
        Rectangle{
            id: recTable
            y: 50
            width: parent.width
            height: parent.height - 160
            HorizontalHeaderView {
                id: horizontalHeaderInfo
                anchors.left: tableScrollViewInfo.left
                anchors.top: parent.top
                syncView: tableViews
                clip: true
                model: ["id","Item Name","Unit","Supplier","QR Code","Bar Code"]
            }
            ScrollView {
                id: tableScrollViewInfo
                anchors.left:  parent.left
                anchors.top: horizontalHeaderInfo.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                ScrollBar.horizontal: ScrollBar {
                    id: horizontalScrollBarInfo
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                ScrollBar.vertical: ScrollBar {
                    id: verticalScrollBarInfo
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                }

                TableView {
                    signal pressAndHold(int index)
                    id: tableViews
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: horizontalScrollBarInfo.top
                    clip: true

                    columnSpacing: 0
                    rowSpacing: 1
                    boundsBehavior: Flickable.StopAtBounds

                    model: myProductModel


                    delegate: Rectangle {
                        id: rectModelInfo
                        implicitWidth: Math.max(tableViews.width / tableViews.columns, horizontalHeaderInfo.itemAtCell(Qt.point(column,0)).width)
                        implicitHeight: 35
                        color: palette.base
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                this.cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                            }
                            onClicked: {
                                infoText.visible = true
                                addText.visible = false
                                recTable.visible = false
                                pageProduct.rowSelect = tableViews.rowAtIndex(tableViews.index(row,column))
                                console.log(rowSelect)
                                pageProduct.editEntry = true
                                pageProduct.creatingNewEntry = false
                                pageProduct.getData(myProductList.get(rowSelect))
                                infoText.infoProduct()
                            }
                        }
                        Label {
                            id: textLabelInfo
                            text: display //+ tableViews.model.data(tableViews.model.index(row, 1), Qt.DisplayRole)
                            width: this.implicitWidth
                            height: parent.height
                            wrapMode: Text.WordWrap
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        states: [
                            State {
                                name: "wide text"
                                when: textLabelInfo.text.length > 50
                                PropertyChanges {
                                    target: textLabelInfo
                                    width: 250
                                    height: textLabelInfo.paintedHeight
                                }
                            },
                            State {
                                name: "not wide text"
                                when: textLabelInfo.text.length <= 20
                                PropertyChanges {
                                    target: textLabelInfo
                                    width: 250
                                    height: textLabelInfo.paintedHeight
                                }
                            }
                        ]
                    }
                }
            }
        }
        states:  [
            State {
                name: "onButton"
                PropertyChanges {
//                    recTable.visible: true
                    recTable.y: addText.visible ? 400 : 50
                    recTable.height: addText.visible ? parent.height - 500 : parent.height - 160
                    addText.height: parent.height - recTable.height - 210
                }
            },

            State {
                name: "rectView"
                PropertyChanges {
                }
            },

            State {
                name: "onButtonViews"
                PropertyChanges {
                }
            }
        ]
    }
}

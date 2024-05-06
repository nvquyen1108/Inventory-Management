import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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
import Inventory.List
import Output.Model

Rectangle{
    id: mainView
    anchors.fill:parent
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
    SqlInventoryList{
        id: myInventoryList
    }
    SqlOutputModel{
        id: myOutputModel
    }

    property alias monthSelector: monthSelector
    property alias yearSelector: yearSelector
    property alias days: daySelector.model
    property alias months: monthSelector.model
    property alias years: yearSelector.model
    property alias currentDay: daySelector.currentIndex
    property alias currentMonth: monthSelector.currentIndex
    property alias currentYear: yearSelector.currentIndex
    width: parent.width
    height: parent.height
    focus: true

    function range(start : int, end : int) : list<int> {
        return new Array(end - start + 1).fill().map((_, idx) => start + idx)
    }

    years: range(2024, 2100)
    months: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    days: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]

    ColumnLayout {
        anchors.fill: parent
        TapView{
            Layout.fillWidth: true
            Layout.preferredHeight: 100
        }
        RowLayout {
            id: rowLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Label{
                text: "XUẤT KHO NGÀY " + daySelector.textAt(mainView.currentDay) + "/" + monthSelector.textAt(mainView.currentMonth) + "/" + yearSelector.textAt(mainView.currentYear)
                Layout.preferredWidth: 10
                Layout.fillWidth: true
                font.pointSize: appSettings.fontSize + 24
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                spacing: 6

                Image {
                    source: "qrc:/mykitchen/images/Before_Icon.svg"

                    TapHandler {
                        id: previousDay
                        onTapped: {
                            if (mainView.currentDay) {
                                mainView.currentDay--
                            } else {
                                mainView.currentDay = mainView.days.length - 1
                            }
                        }
                    }
                }

                ComboBox {
                    id: daySelector

                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    model: mainView.days
                    onCurrentIndexChanged:{
                        myOutputModel.currentDayFunc(daySelector.textAt(mainView.currentDay))
                        myOutputModel.refresh()
                    }
                    Component.onCompleted: currentIndex = find(parseInt(Qt.formatDateTime(new Date(), "d")))
                }
                Image {
                    source: "qrc:/mykitchen/images/Next_Icon.svg"

                    TapHandler {
                        id: nextDay
                        onTapped: {
                            if (mainView.currentDay < mainView.days.length - 1) {
                               mainView.currentDay++
                            } else {
                               mainView.currentDay = 0
                            }
                        }
                    }
                }
            }
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                spacing: 6

                Image {
                    source: "qrc:/mykitchen/images/Before_Icon.svg"

                    TapHandler {
                        id: previousMonth
                        onTapped: {
                            if (mainView.currentMonth) {
                                mainView.currentMonth--
                            } else {
                                mainView.currentMonth = mainView.months.length - 1
                            }
                        }
                    }
                }

                ComboBox {
                    id: monthSelector

                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    model: mainView.months

                    onCurrentIndexChanged:{
                        myOutputModel.currentMonthFunc(monthSelector.textAt(mainView.currentMonth))
                        myOutputModel.refresh()
                    }
                    Component.onCompleted: currentIndex = find(parseInt(Qt.formatDateTime(new Date(), "MM")))
                }
                Image {
                    source: "qrc:/mykitchen/images/Next_Icon.svg"

                    TapHandler {
                        id: nextMonth
                        onTapped: {
                            if (mainView.currentMonth < mainView.months.length - 1) {
                               mainView.currentMonth++
                            } else {
                               mainView.currentMonth = 0
                            }
                        }
                    }
                }
            }
            RowLayout {
                Layout.preferredWidth: 1
                Layout.fillWidth: true
                spacing: 6

                Image {
                    source: "qrc:/mykitchen/images/Before_Icon.svg"

                    TapHandler {
                        id: previousYear
                        onTapped: {
                            if (mainView.currentYear > 0) {
                                mainView.currentYear--
                            }
                        }
                    }
                }

                ComboBox {
                    id: yearSelector
                    Layout.preferredHeight: 40

                    Layout.fillWidth: true
                    model: mainView.years
                    onCurrentIndexChanged:{
                        myOutputModel.currentYearFunc(yearSelector.textAt(mainView.currentYear))
                        myOutputModel.refresh()
                    }
                    Component.onCompleted: currentIndex = find(parseInt(Qt.formatDateTime(new Date(), "yyyy")))
                }

                Image {
                    source: "qrc:/mykitchen/images/Next_Icon.svg"

                    TapHandler {
                        id: nextYear
                        onTapped: {
                            if (mainView.currentYear < mainView.years.length - 1) {
                                mainView.currentYear++
                            }
                        }
                    }
                }
            }
        }
//            MonthGrid {
//                id: monthGrid

//                Layout.fillWidth: true
//                Layout.fillHeight: true
//                locale: Qt.locale("en_US")
//                delegate: Label {
//                    required property var model
//                    color: model.today? "red": "black"
//                    text: monthGrid.locale.toString(model.date, "d")
//                    horizontalAlignment: Text.AlignHCenter
//                    verticalAlignment: Text.AlignVCenter
//                }
//            }
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Rectangle{
                id: recTable
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height - 120 - rowLayout.height

                HorizontalHeaderView {
                    id: horizontalHeaderInfo
                    anchors.left: tableScrollViewInfo.left
                    anchors.top: parent.top
                    syncView: tableViews
                    clip: true
                    model: ["Item Code","Item Name","Unit","Amount"]
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
                        id: tableViews
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: horizontalScrollBarInfo.top
                        clip: true

                        columnSpacing: 1
                        rowSpacing: 1
                        boundsBehavior: Flickable.StopAtBounds

                        model: myOutputModel

                        delegate: Rectangle {
                            id: cellItem
                            implicitWidth: Math.max((tableViews.width - 4) / tableViews.columns, content.width)
                            implicitHeight: 35

                            Rectangle { anchors.left: parent.left; height: parent.height; width: 1; color: "#dddddd"}
                            Rectangle { anchors.top: parent.top; width: parent.width; height: 1; color: "#dddddd"}
                            Rectangle { anchors.right: parent.right; height: parent.height; width: 1; color: "#dddddd"; visible: model.column === tableViews.columns -1 }
                            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#dddddd"; visible: model.row === tableViews.rows - 1 }

                            TextEdit {
                                id: content
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                padding: 4
                                clip: true
                                text: display//tableModel.data(tableModel.index(row, column))
                                selectByMouse: true
                                onEditingFinished: {
                                    //tableModel.setData(tableModel.index(row, column), content.text)
                                }
                            }

                //            MouseArea{
                //                anchors.fill: parent
                //                hoverEnabled: true
                //                onEntered: cellItem.color = "lightsteelblue"
                //                onExited: cellItem.color = "#ffffff"
                //                onClicked: {
                //                    console.log("(", row, ",", column ,")", "[", cellItem.x, ",",cellItem.y, "]")
                //                    console.log(tableModel.rowCount(), tableModel.columnCount())
                //                }
                //            }
                        }
                    }
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                RowLayout{
                    anchors.fill: parent
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: false
                        Layout.preferredWidth: 5
                    }
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: false
                        Layout.preferredWidth: 95
                        Column{
                            anchors.fill: parent
                            spacing: 10
                            Label {
                                text: qsTr("Mã sản phẩm:     ") + grid.idProduct
                                font.pixelSize: appSettings.fontSize + 24
                                Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                            }

                            GridLayout {
                                id: grid
                                property var idProduct: myProductList.getIdOnName(productComboBox.contentItem.text)

                                columns: 2
                                rowSpacing: 20
                                columnSpacing: 10
                                Label {
                                    text: qsTr("Sản phẩm: ")
                                    font.pointSize: appSettings.fontSize
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                                }
                                ComboBox {
                                    id: productComboBox
                                    Layout.preferredHeight: 40
                                    Layout.preferredWidth: 450
                                    flat: true
                                    topInset: 0
                                    bottomInset: 0
                                    model: myInventoryList
                                    contentItem: TextField {
                                        focusReason : Qt.MouseFocusReason
                                        placeholderText: qsTr("Product Name")
                                        anchors.fill: parent
                                        onPressed: {
                                            if(!productComboBox.popup.opened){
                                                productComboBox.popup.open();

                                            }
                                        }
                                        onTextEdited: {
                                            if(!productComboBox.popup.opened){
                                                productComboBox.popup.open();
                                            }
                                        }
                                    }
                                    background: Rectangle {
                                        color: "transparent"
                                        border.color: "transparent"
                                    }
                                    popup: Popup {
                                        y: productComboBox.height
                                        implicitWidth: productComboBox.width
                                        implicitHeight: contentItem.implicitHeight
                                        topPadding: 0
                                        bottomPadding: 0
                                        contentItem: ListView {
                                            clip: true
                                            implicitHeight: contentHeight
                                            implicitWidth: contentWidth
                                            model: productComboBox.delegateModel
                                            boundsBehavior: Flickable.StopAtBounds
                                        }
                                    }
                                    delegate: Text {
                                        text: modelData
                                        width: productComboBox.width
                                        visible: productComboBox.contentItem.text ? text.match(`(${productComboBox.contentItem.text})`, "i") : true
                                        height: visible ? 30 : 0
                                        verticalAlignment: Text.AlignVCenter
                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onEntered: {
                                                this.cursorShape = Qt.PointingHandCursor;
                                            }
                                            onClicked: {
                                                productComboBox.currentIndex = index;
                                                productComboBox.popup.close();
                                                productComboBox.contentItem.text = modelData;
                                            }
                                        }
                                    }
                                }
                                Label {
                                    text: qsTr("Số lượng: ")
                                    font.pointSize: appSettings.fontSize
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                                }

                                TextField {
                                    id: numberCount
                                    focus: true
                                    Layout.preferredWidth: 450
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline

                                    placeholderText: qsTr("Amount")
                                }
                            }
                            RoundButton {
                                text: qsTr("Outbound item")
                                font.pointSize: appSettings.fontSize + 1
                                highlighted: true
                                onClicked: {
                                    myOutputModel.append(grid.idProduct,numberCount.text)
                                    myOutputModel.refresh()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

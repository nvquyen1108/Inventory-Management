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
import Inventory.Model

Item{
    id:pageProduct
//    SqlSuplierList{
//        id: mySupplierList
//    }
//    SqlProductList{
//        id: myProductList
//    }
//    SqlProductModel{
//        id: myProductModel
//    }
//    SaveImages{
//        id: saveImages
//    }
//    SqlUnitModel{
//        id: myUnitModel
//    }
    SqlInventoryModel{
        id: myInventoryModel
    }
    property int rowSelect: -1

    Pane {
        id: mainView

        property alias monthSelector: monthSelector
        property alias yearSelector: yearSelector
        property alias months: monthSelector.model
        property alias years: yearSelector.model
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

        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Label{
                    text: "KIỂM KÊ THÁNG " + monthSelector.textAt(mainView.currentMonth) + "/" + yearSelector.textAt(mainView.currentYear)
                    Layout.preferredWidth: 11
                    Layout.fillWidth: true
                    font.pointSize: fontsizes + 24
                    wrapMode: Text.WordWrap
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
                            myInventoryModel.currentMonthFunc(monthSelector.textAt(mainView.currentMonth))
                            myInventoryModel.refresh()
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
                            myInventoryModel.currentYearFunc(yearSelector.textAt(mainView.currentYear))
                            myInventoryModel.refresh()
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
            Rectangle{
                id: recTable
                width: parent.width
                height: parent.height - 160
                HorizontalHeaderView {
                    id: horizontalHeaderInfo
                    anchors.left: tableScrollViewInfo.left
                    anchors.top: parent.top
                    syncView: tableViews
                    clip: true
                    model: ["Item Code","Item Name","Unit","SL kiểm kê thực tế","Price","Month","Year"]
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

                        model: myInventoryModel

                        delegate: Rectangle {
                            id: rectModelInfo
                            implicitWidth: Math.max(tableViews.width / tableViews.columns, textLabelInfo.width)
                            implicitHeight: 35
                            color: row % 2 ? "steelblue" : "lightsteelblue"
                            Rectangle { anchors.left: parent.left; height: parent.height; width: 1; color: "#dddddd"}
                            Rectangle { anchors.top: parent.top; width: parent.width; height: 1; color: "#dddddd"}
                            Rectangle { anchors.right: parent.right; height: parent.height; width: 1; color: "#dddddd"; visible: model.column === tableViews.columns -1 }
                            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: "#dddddd"; visible: model.row === tableViews.rows - 1 }
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
        }
    }
}

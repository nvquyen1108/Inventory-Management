import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import Suplier.App
import Macai.App

Item {
    id: mainContain

    SqlSuplierModel{
        id: mySuplierModel
    }

    HorizontalHeaderView {
        id: horizontalHeader
        anchors.left: tableScrollView.left
        anchors.top: parent.top
        syncView: tableView
        clip: true
        model: ["ID","Tên nhà cung cấp","Địa chỉ","Điện thoại","Email","Thông tin thêm","Ngày hợp tác"]
    }
    VerticalHeaderView {
        id: verticalHeader
        anchors.top: tableScrollView.top
        anchors.left: parent.left
        syncView: tableView
        clip: true
    }
    ScrollView {
        id: tableScrollView
        anchors.left:  verticalHeader.right
        anchors.top: horizontalHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ScrollBar.horizontal: ScrollBar {
            id: horizontalScrollBar
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }

        ScrollBar.vertical: ScrollBar {
            id: verticalScrollBar
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }

        TableView {
            id: tableView
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: horizontalScrollBar.top
            clip: true

            contentHeight: rowHeightProvider(0) * rows + rowHeightProvider(rows-1)
            rowHeightProvider: function (row) { return 32; }

            columnSpacing: 1
            rowSpacing: 1
            boundsBehavior: Flickable.StopAtBounds

            model: mySuplierModel

            delegate: Rectangle {
                id: rectModel
                implicitWidth: Math.max((tableView.width - textLabel.width) / tableView.columns, textLabel.width) //+ Math.max(horizontalHeader.itemAtCell(Qt.point(column,0)).width, textLabel.width)
                implicitHeight: 20
                color: palette.base
                required property bool selected

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
//                                rectModel.color = "#D9D9D9"
                    }
                    onExited: {
                        textLabel.color = "black"
                    }
                    onClicked: {
                        //mainContain.visible = true
                        //rectGrids.visible = fasle
                        mainContainLoader.source = "qrc:/mykitchen/src/qml/store/suplier/suplierinfo/suplierinfo.qml"
                        suplierTitleText.text = suplierTitleText.text + "/" + mySuplierModel.data(mySuplierModel.index(row, 1),Qt.DisplayRole)
                        //tableView.selectionModel.select(tableView.model.index(index, 0),ItemSelectionModel.Select)

                          // print value from clicked cell
                          var idx = mySuplierModel.index(row,column)
                          console.log("Clicked cell: ", mySuplierModel.data(idx))

                          // print values from all cells in a row
                          console.log("Clicked row: ")
                          for (var i = 0; i < mySuplierModel.columnCount(); i++)
                          {
                            var idx2 = mySuplierModel.index(row,i)
                            var data = mySuplierModel.data(idx2)
                            console.log(" " + data)
                          }
                          tableView.model = data

                    }
                }
                Label {
                    id: textLabel
                    text: display     //+ myTableModel.headerData(row,Qt.Horizontal)
                    width: this.implicitWidth + 20
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}

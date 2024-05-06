import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import Suplier.App
import Macai.App
import Suplier.Add
import Custom

Item {
    id: mainContain
    property int boxWidth: 240
    property int boxHeight: 40

    SqlSuplierList{
        id: mySuplierList
    }
    SqlSuplierModel{
        id: mySuplierModel
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 300
            RowLayout{
                spacing: 150
                Rectangle {
                    id: logoSuplier
                    Layout.preferredWidth: boxWidth
                    Layout.fillHeight: true
                    Layout.leftMargin: 60
                    radius: 5
                    Image {
                        id: imageLogo
                        width: logoSuplier.width
                        height: this.width
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        scale: 0.8
                        source: mlogoFile
                    }
                }
                GridLayout {
                    id: grid
                    property int minimumInputSize: 120

                    rows: 4
                    columns: 4
                    rowSpacing: 20
                    columnSpacing: 10
                    Label {
                        text: qsTr("Tên nhà cung cấp: ")
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        Layout.topMargin: 60
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: mdisplayname
                        elide: Text.ElideRight
                        Layout.topMargin: 60
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: qsTr("Email: ")
                        font.bold: true
                        Layout.topMargin: 60
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: memail
                        elide: Text.ElideRight
                        Layout.topMargin: 60
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }
                    Label {
                        text: qsTr("Address: ")
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: maddress
                        elide: Text.ElideRight
                        Layout.fillWidth: true
//                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }
                    Label {
                        text: qsTr("Điện thoại: ")
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: mphone
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: qsTr("Ngày hợp tác: ")
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }

                    Label {
                        text: mcontractDate
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }
                    Label {
                        text: qsTr("Thông tin thêm: ")
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                    }
                    Rectangle{
                        id: moreInfo_rect
                        Layout.fillWidth: true
                        Layout.preferredWidth: boxWidth
                        Layout.preferredHeight: boxHeight
                        Layout.minimumWidth: grid.minimumInputSize
                        Label {
                            id: moreInfo
                            text: mmoreInfo
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                        }
                        Label {
                            id: dummy_text
                            text: "parent.text"
                            visible: false
                        }
                        states: [
                            State {
                                name: "wide text"
                                when: moreInfo.text.length > 20
                                PropertyChanges {
                                    target: moreInfo
                                    width: 400
                                    height: moreInfo.paintedHeight
                                }
                            },
                            State {
                                name: "not wide text"
                                when: moreInfo.text.length <= 20
                                PropertyChanges {
                                    target: moreInfo
                                    width: 400
                                    height: moreInfo.paintedHeight
                                }
                            }
                        ]
                    }
                }
            }
        }
        Rectangle{
            id: stackLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            TabBar {
                id: addNewSuplierTabBar
                width: parent.width
                background: Rectangle {
                    anchors.fill: parent
                    color: "#F2F2F2"
                }
                TabButton {
                    text: qsTr("Thông tin nhà cung cấp")
                    onClicked: {
                        addNewSuplierTabBar.currentIndex = TabBar.index;
                    }
                    horizontalPadding : 25
                    verticalPadding: 12
                    width: contentItem.implicitWidth + leftPadding + rightPadding
                }
                TabButton {
                    text: qsTr("Thông tin khác")
                    onClicked: {
                        addNewSuplierTabBar.currentIndex = TabBar.index;
                    }
                    horizontalPadding : 25
                    width: contentItem.implicitWidth + leftPadding + rightPadding
                }
            }
            StackLayout {
                width: parent.width
                anchors.top: addNewSuplierTabBar.bottom
                anchors.bottom: footer.top
                currentIndex: addNewSuplierTabBar.currentIndex
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    HorizontalHeaderView {
                        id: horizontalHeaderInfo
                        anchors.left: tableScrollViewInfo.left
                        anchors.top: parent.top
                        syncView: tableViews
                        clip: true
                        model: ["ID","Tên nhà cung cấp","Địa chỉ","Điện thoại","Email","Thông tin thêm","Ngày hợp tác"]
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

                            contentHeight: rowHeightProvider(0) * rows + rowHeightProvider(rows-1)
                            rowHeightProvider: function (row) { return 32; }
//                            columnWidthProvider: function (column) {
//                                return Math.max(1, (tableViews.width - leftMargin) / tableViews.columns)
////                                return Math.max((tableViews.width - textLabelInfo.width) / tableViews.columns - 20, textLabelInfo.width)
//                            }

                            columnSpacing: 0
                            rowSpacing: 1
                            boundsBehavior: Flickable.StopAtBounds

                            model: mySuplierModel

                            delegate: Rectangle {
                                id: rectModelInfo
                                implicitWidth: Math.max((tableViews.width - textLabelInfo.width) / tableViews.columns, textLabelInfo.width)
                                implicitHeight: 20
                                color: palette.base
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
                                    }
                                    onExited: {
                                    }
                                }
                                Label {
                                    id: textLabelInfo
                                    text: display
                                    width: this.implicitWidth
                                    height: parent.height
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
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
    }
}

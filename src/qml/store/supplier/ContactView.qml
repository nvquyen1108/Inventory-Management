import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"

Rectangle{

    signal changeSource(string source)
    property string mdisplayname: ""
    property string maddress: ""
    property string memail: ""
    property string mphone: ""
    property string mmoreInfo: ""
    property string mcontractDate: ""
    property string mlogoFile: ""
    Component.onCompleted: {
        // Gọi phương thức addData() từ myModel để thêm dữ liệu từ cơ sở dữ liệu
    }

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
            text: qsTr("Sản phẩm")
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
        id: stackAdd
        width: parent.width
        anchors.top: addNewSuplierTabBar.bottom
        anchors.bottom: footer.top
        currentIndex: addNewSuplierTabBar.currentIndex
        Rectangle{
            id: recTable
            Layout.fillWidth: true
            Layout.fillHeight: true
            HorizontalHeaderView {
                id: horizontalHeaderInfo
                anchors.left: tableScrollViewInfo.left
                anchors.top: parent.top
                syncView: tableViews
                clip: true
                model: ["id","Item Name","Unit","Supplier","QR Code","Bar Code"]
            }
//            VerticalHeaderView {
//                id: verticalHeader
//                anchors.top: tableScrollViewInfo.top
//                anchors.left: parent.left
//                syncView: tableViews
//                clip: true
//            }

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
    }
    Pane {
        id: footer
        anchors.bottom: parent.bottom
        Material.background: "#FAFAFA"
        width: parent.width
    }
}


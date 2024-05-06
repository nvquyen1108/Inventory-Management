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
    id: mainSuplierInfo
    property int boxWidth: 300
    property int boxHeight: 40

//    SqlSuplierList{
//        id: mySuplierList
//    }

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
                    Layout.topMargin: 60
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
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "red"
        }
//        ContactView{
//            id: contactView
//        }
    }
}

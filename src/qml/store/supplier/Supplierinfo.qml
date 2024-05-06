import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Controls.Material

FocusScope {
    id: menu
    property int boxWidth: 300
    property int boxHeight: 40

    Rectangle {
        anchors.fill: parent
        clip: true
        color: "white"
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
                            width: gridMenu.ilogoFile === "" ? 100 : logoSuplier.width
                            height: this.width
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectFit
                            scale: 0.8
                            source: gridMenu.ilogoFile === "" ? "qrc:/mykitchen/images/upload-icon.png" : gridMenu.ilogoFile
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
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: boxHeight
                            Layout.minimumWidth: grid.minimumInputSize
                        }

                        Label {
                            text: gridMenu.idisplayname
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
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: boxHeight
                            Layout.minimumWidth: grid.minimumInputSize
                        }

                        Label {
                            text: gridMenu.iemail
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
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: boxHeight
                            Layout.minimumWidth: grid.minimumInputSize
                        }

                        Label {
                            text: gridMenu.iaddress
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
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: boxHeight
                            Layout.minimumWidth: grid.minimumInputSize
                        }

                        Label {
                            text: gridMenu.iphone
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
                            text: gridMenu.icontractDate
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
                                text: gridMenu.imoreInfo
                                elide: Text.ElideRight
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
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
            ContactView{
                id:contactView
                width: parent.width
                height: parent.height
                color: "lightgreen"
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 100
            }
        }
    }
}

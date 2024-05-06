import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtCore
import Custom
import Suplier.Add

Dialog {
    id: dialog
    signal finished(string productsName, string unit, string supplier, string qrCode, string barCode, string note, string image)

    function createContact() {
        productsName.clear();
        notes.clear();
        supplierComboBox.contentItem.clear();
        unitComboBox.contentItem.clear();
        qrCode.clear();
        barCode.clear();
        imageLogo.source = "qrc:/mykitchen/images/upload-icon.png"

        dialog.title = qsTr("Add Product");
        dialog.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    title: qsTr("Add Product")
    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: Rectangle {
        anchors.fill: parent
        clip: true
        color: "white"
        radius: 5
        ColumnLayout {
            anchors.fill: parent
            Label {
                text: qsTr("Thêm mới sản phẩm")
                font.weight : Font.DemiBold
                font.pixelSize: fontsizes + 14
                Layout.alignment: Qt.AlignCenter
            }

            RowLayout{
                spacing: 50
                DashRect{
                    id: dashRect
                    width: 250
                    height: this.width
                    Layout.leftMargin: 60
                    FileDialog {
                        id: imageFile
                        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                        onAccepted: {
                            imageLogo.source = selectedFile
                            imageLogo.width = dashRect.width - 10
                            imageLogo.height = this.width
                        }
                    }
                    Image {
                        id: imageLogo
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/mykitchen/images/upload-icon.png"
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            this.cursorShape = Qt.PointingHandCursor
                        }
                        onClicked: {
                            onTriggered:  imageFile.open()
                        }
                    }
                }
                GridLayout {
                    id: grid
                    rows: 4
                    columns: 4
                    rowSpacing: 20
                    columnSpacing: 10
                    Label {
                        text: qsTr("Tên sản phẩm: ")
                        font.pointSize: fontsizes
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: productsName
                        focus: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline

                        placeholderText: qsTr("Products Name")
                    }
                    Label {
                        text: qsTr("Notes")
                        font.pointSize: fontsizes
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField{
                        id: notes
                        font.pointSize: fontsizes
                        focus: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("Notes")
                    }
                    Label {
                        text: qsTr("Tên nhà cung cấp: ")
                        font.pointSize: fontsizes
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }
                    ComboBox {
                        id: supplierComboBox
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 250
                        flat: true
                        topInset: 0
                        bottomInset: 0
                        model: [addMenu.nameSupplier]
                        contentItem: TextField {
                            focusReason : Qt.MouseFocusReason
                            placeholderText: qsTr("Supplier Name")
                            anchors.fill: parent
                            onPressed: {
                                if(!supplierComboBox.popup.opened){
                                    supplierComboBox.popup.open();
                                }
                            }
                            onTextEdited: {
                                if(!supplierComboBox.popup.opened){
                                    supplierComboBox.popup.open();
                                }
                            }
                        }
                        background: Rectangle {
                            color: "transparent"
                            border.color: "transparent"
                        }
                        popup: Popup {
                            y: supplierComboBox.height
                            implicitWidth: supplierComboBox.width
                            implicitHeight: contentItem.implicitHeight
                            topPadding: 0
                            bottomPadding: 0
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                implicitWidth: contentWidth
                                model: supplierComboBox.delegateModel
                                boundsBehavior: Flickable.StopAtBounds
                            }
                        }
                        delegate: Text {
                            text: modelData
                            width: supplierComboBox.width
                            visible: supplierComboBox.contentItem.text ? text.match(`(${supplierComboBox.contentItem.text})`, "i") : true
                            height: visible ? 30 : 0
                            verticalAlignment: Text.AlignVCenter
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    this.cursorShape = Qt.PointingHandCursor;
                                }
                                onClicked: {
                                    supplierComboBox.currentIndex = index;
                                    supplierComboBox.popup.close();
                                    supplierComboBox.contentItem.text = modelData;
                                }
                            }
                        }
                    }
                    Label {
                        text: qsTr("Đơn vị đo: ")
                        font.pointSize: fontsizes
                    }
                    ComboBox {
                        id: unitComboBox
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 250
                        flat: true
                        topInset: 0
                        bottomInset: 0
                        model: myUnitModel
                        contentItem: TextField {
                            focusReason : Qt.MouseFocusReason
                            placeholderText: qsTr("Unit")
                            anchors.fill: parent
                            onPressed: {
                                if(!unitComboBox.popup.opened){
                                    unitComboBox.popup.open();
                                }
                            }
                            onTextEdited: {
                                if(!unitComboBox.popup.opened){
                                    unitComboBox.popup.open();
                                }
                            }
                        }
                        background: Rectangle {
                            color: "transparent"
                            border.color: "transparent"
                        }
                        popup: Popup {
                            y: unitComboBox.height
                            implicitWidth: unitComboBox.width
                            implicitHeight: contentItem.implicitHeight
                            topPadding: 0
                            bottomPadding: 0
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                implicitWidth: contentWidth
                                model: unitComboBox.delegateModel
                                boundsBehavior: Flickable.StopAtBounds
                            }
                        }
                        delegate: Text {
                            text: unitName
                            width: unitComboBox.width
                            visible: unitComboBox.contentItem.text ? text.match(`(${unitComboBox.contentItem.text})`, "i") : true
                            height: visible ? 30 : 0
                            verticalAlignment: Text.AlignVCenter
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    this.cursorShape = Qt.PointingHandCursor;
                                }
                                onClicked: {
                                    unitComboBox.currentIndex = index;
                                    unitComboBox.popup.close();
                                    unitComboBox.contentItem.text = unitName;
                                }
                            }
                        }
                    }
                    Label {
                        text: qsTr("QR Code: ")
                        font.pointSize: fontsizes
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: qrCode
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("QR Code")
                    }
                    Label {
                        text: qsTr("Bar Code: ")
                        font.pointSize: fontsizes
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: barCode
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        placeholderText: qsTr("Bar Code")
                    }
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 100
            }
        }
    }

    onAccepted: finished(productsName.text, unitComboBox.contentItem.text, supplierComboBox.contentItem.text, qrCode.text, barCode.text, notes.text, imageFile.selectedFile)
}

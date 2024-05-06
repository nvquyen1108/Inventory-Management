import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import Custom
import Suplier.Add

FocusScope {
    id: menu
    function initRect(){
        //idObject.clear();
        productsName.clear();
        qrCode.clear();
        unitComboBox.contentItem.clear();
        barCode.clear();
        supplierComboBox.contentItem.clear();
        imageLogo.source = "qrc:/mykitchen/images/upload-icon.png";
    }

    function editContact(contact) {
        idObject.text = contact.id;
        productsName.text = contact.displayName;
        qrCode.text = contact.address;
        unitName.text = contact.email;
        barCode.text = contact.phone;
        supplierName.text = contact.moreinfo;
        imageLogo.source = contact.logoFile;
    }
    property string tIdObject: idObject.text
    property string tProductsName: productsName.text
    property string tQrCode: qrCode.text
    property string tUnitName: unitComboBox.contentItem.text
    property string tBarCode: barCode.text
    property string tSupplierName: supplierComboBox.contentItem.text
    property string tNote: textArea.text
    property string tImageFile: imageFile.selectedFile

    RowLayout{
        anchors.fill: parent
        ColumnLayout {
            Layout.preferredWidth: 4
            Label {
                text: qsTr("Thêm mới sản phẩm")
                font.weight : Font.DemiBold
                font.pixelSize: appSettings.fontSize + 14
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
                        font.pointSize: appSettings.fontSize
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    TextField {
                        id: productsName
                        property string oldString
                        focus: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline

                        placeholderText: qsTr("Products Name")
                    }
                    Label {
                        text: qsTr("")
                        font.pixelSize: appSettings.fontSize + 14
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    }

                    Text {
                        id: idObject
                        text: ""
                        property string oldString
                        font.pointSize: appSettings.fontSize + 14
                        focus: true
                        Layout.fillWidth: true
                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
//                        placeholderText: qsTr("Id")
                    }
                    Label {
                        text: qsTr("Tên nhà cung cấp: ")
                        font.pointSize: appSettings.fontSize
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
                        model: mySupplierList

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
                            text: displayName
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
                                    supplierComboBox.contentItem.text = displayName;
                                }
                            }
                        }
                    }
                    Label {
                        text: qsTr("Đơn vị đo: ")
                        font.pointSize: appSettings.fontSize
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
                        font.pointSize: appSettings.fontSize
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
                        font.pointSize: appSettings.fontSize
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
        Column {
            id: columnTextArea
            Layout.preferredWidth: 1
            Layout.fillWidth: true
            Layout.fillHeight: true
            property alias text: textArea.text

            spacing: 10

            Label {
                id:labels
                text: qsTr("Notes")
                font.pixelSize: appSettings.fontSize + 6
                color: "black"
            }

            ScrollView {
                width: columnTextArea.width
                height: columnTextArea.height - labels.height - spacing
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                TextArea {
                    id: textArea

                    wrapMode: TextArea.Wrap
                    background:Rectangle{
                        implicitWidth: pageProduct.width
                        implicitHeight: 40
                        radius: 3
                        border.color: "black"
                    }
                }
            }
        }
        Rectangle{
            Layout.preferredWidth: 0.1
            Layout.fillHeight: true
        }
    }
}

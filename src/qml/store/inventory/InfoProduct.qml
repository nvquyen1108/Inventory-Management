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
    function infoProduct() {
        idObject.text = pageProduct.mIdObject;
        productsName.text = pageProduct.mProductsName;
        qrCode.text = pageProduct.mQrCode;
        unitComboBox.contentItem.text = pageProduct.mUnitName;
        barCode.text = pageProduct.mBarCode;
        supplierComboBox.contentItem.text = pageProduct.mSupplierName;
        imageLogo.source = pageProduct.mImageFile;
        textArea.text = pageProduct.mNote;
    }
    property string eIdObject: idObject.text
    property string eProductsName: productsName.text
    property string eQrCode: qrCode.text
    property string eUnitName: unitComboBox.contentItem.text
    property string eBarCode: barCode.text
    property string eSupplierName: supplierComboBox.contentItem.text
    property string eNote: textArea.text
    property string eImageFile: logoFile.selectedFile

    ColumnLayout {
        anchors.fill: parent
        Label {
            id: label
            text: qsTr("Update sản phẩm")
            font.weight : Font.DemiBold
            font.pixelSize: appSettings.fontSize + 14
            Layout.alignment: Qt.AlignCenter
        }
        RowLayout{
            id:rowText
            spacing: 50
            Rectangle{
                id: dashRect
                width: 250
                height: this.width
                Layout.leftMargin: 60
                border.color: "black"
                FileDialog {
                    id: logoFile
                    currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                    onAccepted: {
                        imageLogo.source = selectedFile
                        imageLogo.width = dashRect.width - 10
                        imageLogo.height = this.width
                    }
                }
                Image {
                    id: imageLogo
                    width: dashRect.width
                    height: this.width
                    scale: 0.8
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
                        onTriggered:  logoFile.open()
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
                    text: qsTr("Mã sảm phẩm:")
                    font.pixelSize: appSettings.fontSize + 14
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Text {
                    id: idObject
                    text: ""
                    font.pointSize: appSettings.fontSize + 14
                    focus: true
                    Layout.leftMargin: 20
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
                    model: SqlSuplierList{
                        id: mySupplierList
                    }
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
        Rectangle{
            id: stackView
            width: menu.width
            height: menu.height - rowText.height -label.height
            TabBar {
                id: addNewSuplierTabBar
                width: parent.width
                background: Rectangle {
                    anchors.fill: parent
                    color: "#F2F2F2"
                }
                TabButton {
                    text: qsTr("Thông tin chung")
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
                Column {
                    id: columnTextArea
                    property alias text: textArea.text

                    spacing: 10

                    Label {
                        id:labels
                        text: qsTr("Notes")
                        font.pixelSize: appSettings.fontSize + 6
                        color: "black"
                    }

                    ScrollView {
                        width: stackView.width - 5
                        height: stackView.height - labels.height - spacing -200
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

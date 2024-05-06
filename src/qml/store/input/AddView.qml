import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore
import QtQuick.Controls.Material
import "qrc:/mykitchen/src/qml/components"

FocusScope {
    id: menu
    property var idSupplier: mySupplierList.getIdOnName(supplierComboBox.contentItem.text)
    property string nameSupplier: supplierComboBox.contentItem.text
    function initCreate(){
        supplierComboBox.contentItem.clear();
        supplierId.clear();
        imageLogo.source = "qrc:/mykitchen/images/upload-icon.png";
    }

    InputSupplierDialog{
        id: inputDialog
        width: parent.width/2
        height: parent.height*2
        onFinished: function(fullName, email, address, phone, moreInfo, imageLogo) {
            if (fullName === "" && address === "" && email === "" && phone === "" && moreInfo === ""){
                mDialog.visible = true
            }else if(mySupplierList.append(fullName,address,email,phone,moreInfo,imageLogo)){
                supplierComboBox.model = mySupplierList
                inputDialog.createContact();
            }else{
                mDialog.visible = true
                mDialog.title = "Thông tin email không được để trống hoặc email đã bị trùng. vui lòng kiểm tra lại"
            }
        }
        Dialog {
            id: mDialog
            visible: false
            focus: true
            modal: true
            title: qsTr("Bạn chưa nhập thông tin")
            standardButtons: Dialog.Cancel
        }
    }
    ColumnLayout {
        anchors.fill: parent
        Label {
            id: label
            text: qsTr("Input Product")
            font.weight : Font.DemiBold
            font.pixelSize: fontsizes + 14
            Layout.alignment: Qt.AlignCenter
        }
        RowLayout{
            id:rowText
            spacing: 50
            Rectangle{
                id: dashRect
                width: 150
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
                rows: 2
                columns: 2
                rowSpacing: 20
                columnSpacing: 30

                Label {
                    text: qsTr("Nhà cung cấp: ")
                    font.pointSize: fontsizes
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }
                ComboBox {
                    id: supplierComboBox
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 450
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
                        implicitHeight: contentItem.implicitHeight + popupButton.height
                        topPadding: 0
                        bottomPadding: 0
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            implicitWidth: contentWidth
                            model: supplierComboBox.delegateModel
                            boundsBehavior: Flickable.StopAtBounds
                        }
                        RoundButton {
                            id: popupButton
                            text: qsTr("+")
                            highlighted: true
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            onClicked: {
                                inputDialog.createContact()
                            }
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
                                contactView.nameTypeComboBox.model = myProductList.getNameOnSupplier(addMenu.idSupplier)
                            }
                        }
                    }
                }
                Label {
                    text: qsTr("Mã nhà cung cấp: ")
                    font.pointSize: fontsizes
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: supplierId
                    text: idSupplier
                    focus: true
                    Layout.preferredWidth: 450
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline

                    placeholderText: qsTr("Supplier Id")
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
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

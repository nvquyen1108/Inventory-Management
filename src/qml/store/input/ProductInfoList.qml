import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import QtQuick.Dialogs
import "qrc:/mykitchen/src/qml/components"

RowLayout {
    id: components
    property var idProduct: myProductList.getIdOnName(nameTypeComboBox.contentItem.text)
    property var nameProduct: myProductList.getNameOnSupplier(addMenu.idSupplier)
    property var unitName: myUnitModel.getUnitOnObject(myProductList.getIdOnName(nameTypeComboBox.contentItem.text))
    property alias idType: idType
    property alias nameTypeComboBox: nameTypeComboBox
    property alias numberType: numberType
    property alias unitTypeComboBox: unitTypeComboBox
    property alias inputPriceType: inputPriceType
    property alias noteType: noteType

    function initCreate(){
        idType.clear()
        nameTypeComboBox.contentItem.clear()
        numberType.clear()
        unitTypeComboBox.contentItem.clear()
        inputPriceType.clear()
        noteType.clear()
    }

    InputProductDialog{
        id: inputDialog
        width: parent.width
        height: parent.height * 12
        onFinished: function(productsName, unit, supplier, qrCode, barCode, note, image) {
            if(productsName === ""){
                mDialog.visible = true
            }else if(myUnitModel.append(unit)){
                myProductModel.append(productsName, unit, supplier, qrCode, barCode, note, image)
                nameTypeComboBox.model = myProductList.getNameOnSupplier(addMenu.idSupplier)
                inputDialog.createContact()
            }else{
                mDialog.visible = true
                mDialog.title = "Tên nhà cung cấp và đơn vị đo \nkhông hợp lệ hoặc không có sẵn"
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

    TextField {
        id: idType
        text: idProduct
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        placeholderText: qsTr("Mã sản phẩm")
    }
    ComboBox {
        id: nameTypeComboBox //nameTypeComboBox.contentItem.text
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        flat: true
        topInset: 0
        bottomInset: 0
        model: nameProduct
        contentItem: TextField {
            placeholderText: qsTr("Tên sản phẩm")
            anchors.fill: parent
            onPressed: {
                if(!nameTypeComboBox.popup.opened){
                    nameTypeComboBox.popup.open();
                }
            }
            onTextEdited: {
//                nameProduct = myProductList.getNameOnSupplier(addMenu.idSupplier)
                if(!nameTypeComboBox.popup.opened){
                    nameTypeComboBox.popup.open();
                }
            }
        }
        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
        }
        popup: Popup {
            y: nameTypeComboBox.height
            implicitWidth: nameTypeComboBox.width
            implicitHeight: contentItem.implicitHeight + popupButton.height
            topPadding: 0
            bottomPadding: 0
            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                implicitWidth: contentWidth
                model: nameTypeComboBox.popup.visible ? nameTypeComboBox.delegateModel : null
                boundsBehavior: Flickable.StopAtBounds
            }
            RoundButton {
                id: popupButton
                visible: true
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
            id: textC
            text: modelData
            width: nameTypeComboBox.width
            visible: nameTypeComboBox.contentItem.text ? text.match(`(${nameTypeComboBox.contentItem.text})`, "i") : true
            height: visible ? 30:0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    this.cursorShape = Qt.PointingHandCursor;
                }
                onClicked: {
                    nameTypeComboBox.currentIndex = index;
                    nameTypeComboBox.popup.close();
                    nameTypeComboBox.contentItem.text = modelData;
                    unitTypeComboBox.model = myUnitModel.getUnitOnObject(idProduct)
                }
            }
        }
    }
    TextField {
        id: numberType
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        placeholderText: qsTr("Số lượng")
    }
    ComboBox {
        id: unitTypeComboBox //unitTypeComboBox.contentItem.text
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        flat: true
        topInset: 0
        bottomInset: 0
        model: [unitName]
        contentItem: TextField {
            placeholderText: qsTr("Đơn vị")
            anchors.fill: parent
            onPressed: {
                if(!unitTypeComboBox.popup.opened){
                    unitTypeComboBox.popup.open();
                }
            }
            onTextEdited: {
                if(!unitTypeComboBox.popup.opened){
                    unitTypeComboBox.popup.open();
                }
            }
        }
        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
        }
        popup: Popup {
            y: unitTypeComboBox.height
            implicitWidth: unitTypeComboBox.width
            implicitHeight: contentItem.implicitHeight
            topPadding: 0
            bottomPadding: 0
            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                implicitWidth: contentWidth
                model: unitTypeComboBox.delegateModel
                boundsBehavior: Flickable.StopAtBounds
            }
        }
        delegate: Text {
            text: modelData
            width: unitTypeComboBox.width
            visible: unitTypeComboBox.contentItem.text ? text.match(`(${unitTypeComboBox.contentItem.text})`, "i") : true
            height: visible ? 30 : 0
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    this.cursorShape = Qt.PointingHandCursor;
                }
                onClicked: {
                    unitTypeComboBox.currentIndex = index;
                    unitTypeComboBox.popup.close();
                    unitTypeComboBox.contentItem.text = modelData;
                }
            }
        }
    }
    TextField {
        property bool success: false
        id: inputPriceType
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        placeholderText: qsTr("Input Price")
        onSuccessChanged:{
            if(success){}
        }
    }
    TextField {
        id: noteType
        Layout.preferredHeight: boxHeight
        Layout.preferredWidth: boxWidth
        placeholderText: qsTr("Note")
    }
    Image {
        Layout.preferredHeight: 15
        Layout.preferredWidth: 15
        Layout.leftMargin: 5
        source: "qrc:/mykitchen/images/clear.png"
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                this.cursorShape = Qt.PointingHandCursor
            }
            onClicked: {
                components.destroy();
            }
        }
    }
}

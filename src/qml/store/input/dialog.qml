import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Dialog {
    id: dialog
    visible: false

    signal finished(string fullName, string address, string city, string number)

    function createContact() {
        form.fullName.clear();
        form.address.clear();
        form.city.clear();
        form.number.clear();

        dialog.title = qsTr("Add Contact");
        dialog.open();
    }

    function editContact(contact) {
        form.fullName.text = contact.fullName;
        form.address.text = contact.address;
        form.city.text = contact.city;
        form.number.text = contact.number;

        dialog.title = qsTr("Edit Contact");
        dialog.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    title: qsTr("Add Contact")
    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: GridLayout {
        id: grid
        property alias fullName: fullName
        property alias address: address
        property alias city: city
        property alias number: number
        property int minimumInputSize: 120
        property string placeholderText: qsTr("<enter>")

        rows: 4
        columns: 2

        Label {
            text: qsTr("Full Name")
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        }

        TextField {
            id: fullName
            focus: true
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            placeholderText: grid.placeholderText
        }

        Label {
            text: qsTr("Address")
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        }

        TextField {
            id: address
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            placeholderText: grid.placeholderText
        }

        Label {
            text: qsTr("City")
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        }

        TextField {
            id: city
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            placeholderText: grid.placeholderText
        }

        Label {
            text: qsTr("Number")
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        }

        TextField {
            id: number
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
            placeholderText: grid.placeholderText
        }
    }

    onAccepted: finished(form.fullName.text, form.address.text, form.city.text, form.number.text)
}

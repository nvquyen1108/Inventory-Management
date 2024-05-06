import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FocusScope {
    id: main

    property alias mainLoader: mainLoader

    width: parent.width
    height: parent.height
    focus: true
    RowLayout{
        anchors.fill: parent
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Loader{
                anchors.fill: parent
                id: mainLoader
            }
        }
    }
}

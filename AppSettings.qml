import QtQuick
import QtCore

Settings {
    id: settings

    property string style
    property string theme: Qt.styleHints.colorScheme === Qt.Dark ? "Dark" : "Light"
    property int maxTasksCount: 20
    property int fontSize: 10
    property bool removeDoneTasks: false
}

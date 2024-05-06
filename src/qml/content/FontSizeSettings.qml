import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "qrc:/mykitchen/src/qml/setting"

FontSizeSettingsForm{
    backButton.onClicked: StackView.view.pop()
}

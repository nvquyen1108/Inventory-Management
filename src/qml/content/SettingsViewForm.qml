import QtQuick
import QtQuick.Controls

Page {
    id: root

    property var builtInStyles
    property var themeSettingsModel
    property var tasksSettingsModel
    property bool isThemeOptionAvailable

    property alias backButton: navBar.backButton

    header: NavBarForm {
        id: navBar

        titleText: qsTr("Settings")
//        previousPageTitle: qsTr(" ")
        backButton.visible: false
    }

    ListModel {
        id: settings

        ListElement {
            setting: qsTr("Theme")
            page: "Theme"
            iconSource: "qrc:/mykitchen/src/qml/content/images/Theme_Icon.svg"
        }
        ListElement {
            setting: qsTr("Font Size")
            page: "FontSize"
            iconSource: "qrc:/mykitchen/src/qml/content/images/Font_Size_Icon.svg"
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: settings
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        delegate: ItemDelegate {
            id: settingsItem

            required property string setting
            required property string page
            required property string iconSource

            width: parent.width
            text: settingsItem.setting
            font.pixelSize: appSettings.fontSize+6
            icon.source: settingsItem.iconSource
            icon.color: "black"

            Image {
                source: "qrc:/mykitchen/images/Right_Arrow_Icon_Dark.svg"
                width: 20
                height: 20
                anchors.right: parent.right
                anchors.rightMargin: 10
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }

            Connections {
                function onClicked() {
                    if (settingsItem.page === "Style") {
                        stackView.push(settingsItem.page + "Settings.qml", {
                                           "builtInStyles": root.builtInStyles
                                       })
                    } else if (settingsItem.page === "Theme") {
                        stackView.push("OtherSettings.qml", {
                                           "otherSettingsModel": themeSettingsModel,
                                           "titleText": qsTr("Theme")
                                       })
                    } else if (settingsItem.page === "Tasks") {
                        stackView.push("OtherSettings.qml", {
                                           "otherSettingsModel": tasksSettingsModel,
                                           "titleText": qsTr("Tasks")
                                       })
                    } else {
                        stackView.push(settingsItem.page + "Settings.qml")
                    }
                }
            }
        }
    }

    //Prepare the model to include only the setting options available in current style.
//    Connections {
//        target: Component
//        function onCompleted() {
//            for (var i = 0; i < settings.count; i++) {
//                if (settings.get(i).page === "Theme"
//                        && !root.isThemeOptionAvailable) {
//                    settings.remove(i)
//                    return
//                }
//            }
//        }
//    }
}

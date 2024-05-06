import QtQuick
import QtQuick.Controls
import "qrc:/mykitchen/src/qml/shared"


Item {
    id: root
    StackView {
        id: stackView

        anchors.fill: parent
        initialItem:Item{
            id: items
            ListModel {
                id: settings

                ListElement {
                    setting: qsTr("Font Size")
                    page: "FontSize"
                    iconSource: "qrc:/mykitchen/images/Font_Size_Icon.svg"
                }
            }

            ListView {
                id: listView
                anchors.fill: parent
                model: settings
                clip: true

                delegate: ItemDelegate {
                    id: settingsItem

                    required property string setting
                    required property string page
                    required property string iconSource

                    width: parent.width
                    text: settingsItem.setting + " " +appSettings.fontSize
                    font.pixelSize: appSettings.fontSize
                    icon.source: settingsItem.iconSource
    //                                                icon.color: "white"
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
                            if (settingsItem.page === "FontSize") {
                                stackView.push("qrc:/mykitchen/src/qml/content/FontSizeSettingsForm.qml")
                            } else {
                                stackView.push(settingsItem.page + "Settings.qml")
                            }
                        }
                    }
                }
            }
        }
//        Component.onCompleted: StackView.view.push("qrc:/mykitchen/src/qml/content/FontSizeSettingsForm.qml")
    }
}

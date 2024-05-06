import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
//import "src/qml/socialNetwork/components"

QtObject {
    id: root
    property real defaultSpacing: 10

    property var controlWindow: Window {
        width: Screen.width
        height: Screen.height
        color: palette.window
//        visibility: Window.Maximized
//        visibility: Qt.WindowFullScreen
        title: qsTr("My Kitchen")
        AppSettings{
            id: appSettings
        }

        Loader {
            id: loader_screen
            anchors.fill: parent
            source: "qrc:/mykitchen/src/qml/screens/login.qml" //Don't remove this line (!importain)
//            source: "qrc:/mykitchen/src/qml/screens/mainScreen.qml"
        }

         //Don't remove comment lines bellow (!importain)
        Connections {
            target: loader_screen.item
            function onChangeScreen(source) {
                if (source && source != "") {
                    loader_screen.source = source
                }
            }
        }
    }
    property var splashWindow: Splash {
        visible: true
        onTimeout: {
            root.controlWindow.visible = true
            if(root.controlWindow.visible === true){
                   root.controlWindow.visibility = Window.Maximized
            }
        }
    }
}

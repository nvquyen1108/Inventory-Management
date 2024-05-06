import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import "qrc:/mykitchen/src/qml/socialNetwork/components"
import "qrc:/mykitchen/src/qml/content"

Rectangle {
    id: root
    anchors.fill:parent
    signal changeScreen(string source)
    Image {
        id: background
            width: parent.width
            height: parent.height
            source: "qrc:/mykitchen/images/background.jpg"
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
                id: navBar
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                z: 1
//                color: Qt.rgba(255, 102, 0.9, 0.5)
//                    color: "#faebd7"
                color: "#1278c0"
                RowLayout {
                    id: navBarRowLayout
                    width: parent.width
                    height: parent.height-navBarLine.height
                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                    spacing: 0
                    Rectangle {
                        id: menuNavigation
                        color: "transparent"
                        Layout.fillHeight: true
                        Layout.preferredWidth: childrenRect.width + 20
                        Rectangle {
                            id: mainMenuNavigation
                            width: parent.height
                            height: parent.height
                            color: "transparent"
                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                                leftMargin: 20
                            }
                            MouseArea {
                                id: mainMenuNavigationIconMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onExited: {
                                    if(mainMenuNavigationRectMouseArea.containsMouse) {
                                        mainMenuNavigationRect.visible = true
                                    } else {
                                        mainMenuNavigationRect.visible = false
                                    }
                                }
                                Rectangle {
                                    color: "transparent"
                                    width: parent.width/2
                                    height: parent.width/2
                                    anchors.centerIn: parent
                                    radius: this.width/2
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            this.cursorShape = Qt.PointingHandCursor
                                            parent.color = "#D9D9D9"
                                            mainMenuNavigationRect.visible = true
                                        }
                                        onExited: {
                                            parent.color = "transparent"
                                        }
                                        onClicked: {
                                            mainMenuNavigationRect.visible = false
                                            menuNavigationText.text = homeText.text
                                            menuListing.model = homeListModel
                                            menuListing.currentIndex = menuListing.model.index

                                            mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                            changeHome();
                                        }
                                    }
                                    Image {
                                        id: mainMenuNavigationIcon
                                        height: parent.height*0.5
                                        fillMode: Image.PreserveAspectFit
                                        source: "qrc:/mykitchen/images/grid.png"
                                        opacity: 0.8
                                        anchors.centerIn:parent
                                    }
                                }

                            }
                            Rectangle {
                                id: mainMenuNavigationRect
                                width: root.width*0.15
                                height: mainMenuNavigationRectColumn.childrenRect.height
//                                color: Qt.rgba(255, 102, 0.9, 0.5)
                                color: "#ffffff"
                                visible: false
                                radius: 5
                                anchors {
                                    left: parent.left
                                    top: parent.bottom
                                }
                                MouseArea {
                                    id: mainMenuNavigationRectMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onExited: {
                                        mainMenuNavigationRect.visible = false
                                    }
                                    Column {
                                        id: mainMenuNavigationRectColumn
                                        width: parent.width*0.9
                                        anchors.top: parent.top
                                        anchors.centerIn: parent
                                        topPadding: 10
                                        bottomPadding: 10
                                        spacing: 2
                                        Rectangle{
                                            width: parent.width
                                            height: 60
                                            color: "transparent"
                                            radius: 3
                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.color = "#D9D9D9"
                                                    this.cursorShape = Qt.PointingHandCursor
                                                }
                                                onExited: {
                                                    parent.color = "transparent"
                                                }
                                                onClicked: {
                                                    mainMenuNavigationRect.visible = false
                                                    menuNavigationText.text = homeText.text
                                                    menuListing.model = homeListModel
                                                    menuListing.currentIndex = menuListing.model.index

//                                                    sideBarListingModelLoader.source = "";
                                                    mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                                    changeHome();
                                                }
                                            }
                                            Row {
                                                anchors.fill: parent
                                                spacing: 10
                                                leftPadding: 10
                                                Image {
                                                    height: parent.height*0.4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/mykitchen/images/home.png"
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                                Text {
                                                    id: homeText
                                                    text: "Home"
                                                    font.pointSize: appSettings.fontSize + 2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width
                                            height: 60
                                            color: "transparent"
                                            radius: 3
                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.color = "#D9D9D9"
                                                    this.cursorShape = Qt.PointingHandCursor
                                                }
                                                onExited: {
                                                    parent.color = "transparent"
                                                }
                                                onClicked: {
                                                    mainMenuNavigationRect.visible = false
                                                    menuNavigationText.text = hrmText.text
                                                    menuListing.model = storeListModel
                                                    menuListing.currentIndex = menuListing.model.index
//                                                    sideBarListingModelLoader.source = menuListing.model.get(menuListing.model.index).src;

                                                    changeBody();
                                                    mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                                }
                                            }
                                            Row {
                                                anchors.fill: parent
                                                spacing: 10
                                                leftPadding: 10
                                                Image {
                                                    height: parent.height*0.4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/mykitchen/images/hrm.png"
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                                Text {
                                                    id: hrmText
                                                    text: "Kho"
                                                    font.pointSize: appSettings.fontSize +2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width
                                            height: 60
                                            color: "transparent"
                                            radius: 3
                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.color = "#D9D9D9"
                                                    this.cursorShape = Qt.PointingHandCursor
                                                }
                                                onExited: {
                                                    parent.color = "transparent"
                                                }
                                                onClicked: {
                                                    mainMenuNavigationRect.visible = false
                                                    menuNavigationText.text = inputText.text
                                                    menuListing.model = inputListModel
                                                    menuListing.currentIndex = menuListing.model.index
                                                    changeBody();
                                                    mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                                }
                                            }
                                            Row {
                                                anchors.fill: parent
                                                spacing: 10
                                                leftPadding: 10
                                                Image {
                                                    height: parent.height*0.4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/mykitchen/images/scm.png"
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                                Text {
                                                    id: inputText
                                                    text: "Nhập kho"
                                                    font.pointSize: appSettings.fontSize +2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width
                                            height: 60
                                            color: "transparent"
                                            radius: 3
                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.color = "#D9D9D9"
                                                    this.cursorShape = Qt.PointingHandCursor
                                                }
                                                onExited: {
                                                    parent.color = "transparent"
                                                }
                                                onClicked: {
                                                    mainMenuNavigationRect.visible = false
                                                    menuNavigationText.text = outputText.text
                                                    menuListing.model = outputListModel
                                                    menuListing.currentIndex = menuListing.model.index
                                                    changeBody();
                                                    mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                                }
                                            }
                                            Row {
                                                anchors.fill: parent
                                                spacing: 10
                                                leftPadding: 10
                                                Image {
                                                    height: parent.height*0.4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/mykitchen/images/scm.png"
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                                Text {
                                                    id: outputText
                                                    text: "Xuất kho"
                                                    font.pointSize: appSettings.fontSize +2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                        Rectangle{
                                            width: parent.width
                                            height: 60
                                            color: "transparent"
                                            radius: 3
                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.color = "#D9D9D9"
                                                    this.cursorShape = Qt.PointingHandCursor
                                                }
                                                onExited: {
                                                    parent.color = "transparent"
                                                }
                                                onClicked: {
                                                    mainMenuNavigationRect.visible = false
                                                    menuNavigationText.text = suplierText.text
                                                    menuListing.model = suplierListModel
                                                    menuListing.currentIndex = menuListing.model.index
                                                    changeBody();
                                                    mainContainLoader.source = menuListing.model.get(menuListing.model.index).src
                                                }
                                            }
                                            Row {
                                                anchors.fill: parent
                                                spacing: 10
                                                leftPadding: 10
                                                Image {
                                                    height: parent.height*0.4
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/mykitchen/images/scm.png"
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                                Text {
                                                    id: suplierText
                                                    text: "Nhà cung cấp"
                                                    font.pointSize: appSettings.fontSize +2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Text {
                            id: menuNavigationText
                            text: "Home"
                            color: "white"
                            font.pointSize: appSettings.fontSize + 14
                            anchors {
                                left: mainMenuNavigation.right
                                leftMargin: 10
                                verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Rectangle {
                        id: menu
                        color: "transparent"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.width*0.5
                        ListModel {
                            id: homeListModel
                            property int index : 0
                            property string type: "homeListModel"
                            ListElement {name: " "; src:"qrc:/mykitchen/src/qml/screens/mainScreen.qml"}
//                            ListElement { name: "operations"; src:"qrc:/mykitchen/src/qml/hrm/hrPlanningAndEmployment/hrPlanningAndEmployment.qml"}
//                            ListElement { name: "Products"; src:"qrc:/mykitchen/src/qml/hrm/talentAndPerformenceManagement/talentAndPerformenceManagement.qml"}
//                            ListElement { name: "Reporting"; src:"qrc:/mykitchen/src/qml/hrm/totalRewards/totalRewards.qml"}
//                            ListElement { name: "Configuration"; src:"qrc:/mykitchen/src/qml/hrm/employeeRelationsAndInvovement/employeeRelationsAndInvovement.qml"}
                        }

                        ListModel {
                            id: storeListModel
                            property int index : 0
                            property string type: "storeListModel"
                            ListElement { name: "Overview"; src:"qrc:/mykitchen/src/qml/store/inventory/storeHome.qml"}
//                            ListElement { name: "operations"; src:"qrc:/mykitchen/src/qml/store/orderdaily/order.qml"}
//                            ListElement { name: "Products"; src:"qrc:/mykitchen/src/qml/hrm/talentAndPerformenceManagement/talentAndPerformenceManagement.qml"}
//                            ListElement { name: "Reporting"; src:"qrc:/mykitchen/src/qml/hrm/totalRewards/totalRewards.qml"}
//                            ListElement { name: "Configuration"; src:"qrc:/mykitchen/src/qml/hrm/employeeRelationsAndInvovement/employeeRelationsAndInvovement.qml"}
                        }
                        ListModel {
                            id: inputListModel
                            property int index : 0
                            property string type: "inputListModel"
                            ListElement { name: "input"; src:"qrc:/mykitchen/src/qml/store/input/input.qml"}
//                            ListElement { name: "vendors"; src:"qrc:/mykitchen/src/qml/store/orderdaily/vendors.qml"}
//                            ListElement { name: "Products"; src:"qrc:/mykitchen/src/qml/hrm/talentAndPerformenceManagement/talentAndPerformenceManagement.qml"}
//                            ListElement { name: "Reporting"; src:"qrc:/mykitchen/src/qml/hrm/totalRewards/totalRewards.qml"}
//                            ListElement { name: "Configuration"; src:"qrc:/mykitchen/src/qml/hrm/employeeRelationsAndInvovement/employeeRelationsAndInvovement.qml"}
                        }
                        ListModel {
                            id: outputListModel
                            property int index : 0
                            property string type: "outputListModel"
                            ListElement { name: "output"; src:"qrc:/mykitchen/src/qml/store/output/output.qml"}
//                            ListElement { name: "vendors"; src:"qrc:/mykitchen/src/qml/store/orderdaily/vendors.qml"}
//                            ListElement { name: "Products"; src:"qrc:/mykitchen/src/qml/hrm/talentAndPerformenceManagement/talentAndPerformenceManagement.qml"}
//                            ListElement { name: "Reporting"; src:"qrc:/mykitchen/src/qml/hrm/totalRewards/totalRewards.qml"}
//                            ListElement { name: "Configuration"; src:"qrc:/mykitchen/src/qml/hrm/employeeRelationsAndInvovement/employeeRelationsAndInvovement.qml"}
                        }
                        ListModel {
                            id: suplierListModel
                            property int index : 0
                            property string type: "suplierListModel"
                            ListElement { name: "suplier"; src:"qrc:/mykitchen/src/qml/store/supplier/supplier.qml"}
//                            ListElement { name: "vendors"; src:"qrc:/mykitchen/src/qml/store/supplier/supplier.qml"}
//                            ListElement { name: "Products"; src:"qrc:/mykitchen/src/qml/hrm/talentAndPerformenceManagement/talentAndPerformenceManagement.qml"}
//                            ListElement { name: "Reporting"; src:"qrc:/mykitchen/src/qml/hrm/totalRewards/totalRewards.qml"}
//                            ListElement { name: "Configuration"; src:"qrc:/mykitchen/src/qml/hrm/employeeRelationsAndInvovement/employeeRelationsAndInvovement.qml"}
                        }
                        ListView {
                            id: menuListing
                            width: parent.width
                            model:  homeListModel
                            spacing: 10
                            anchors.fill: parent
                            anchors.leftMargin: 30
                            delegate: menuModelDelegate
                            orientation: ListView.Horizontal
                            clip: true
                            boundsBehavior: Flickable.StopAtBounds
                        }

                        Component {
                            id: menuModelDelegate

                            Rectangle {
                                id: menuItem
                                width: childrenRect.width
                                height: menuListing.height*0.6
                                anchors.verticalCenter: parent.verticalCenter
                                color: "transparent"
                                visible: true
                                radius: 3

                                Text {
                                    id: menuText
                                    text: name
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pointSize: appSettings.fontSize
                                    font.weight : Font.DemiBold
                                    padding: 5
                                    color: "white"
//                                    color: parent.ListView.isCurrentItem ? "#D9D9D9" : "white"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        menuListing.currentIndex = index;
                                        menuListing.model.index = index;
                                        mainContainLoader.source = src
                                    }
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
//                                        menuText.color = "#D9D9D9"
                                    }
                                    onExited: {
//                                        menuText.color = "white"
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        color: "transparent"
                        Layout.fillHeight: true
                        Layout.preferredWidth: childrenRect.width + 20
                        Row {
                            width: childrenRect.width
                            height: parent.height
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            layoutDirection: Qt.RightToLeft
                            Rectangle{
                                id: mySettings
                                height: parent.height
                                width: 40
                                color: "transparent"

                                Image {
                                    id: mySettingsImage
                                    source: "qrc:/mykitchen/images/Settings_Icon.svg"
                                    width: 20
                                    height: this.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    fillMode: Image.PreserveAspectFit
                                    visible: true
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: Rectangle {
                                            anchors.fill: parent
                                            width: mySettingsImage.width
                                            height: mySettingsImage.height
                                            radius: this.width/2
                                        }
                                    }
                                }
                                MouseArea {
                                    id: mySettingsMouseArea
                                    anchors.fill: mySettings
                                    hoverEnabled: true
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
//                                        mySettingsDirection.visible = true
                                    }
                                    onExited: {
//                                        if(!mySettingsDirectionMouseArea.containsMouse){
//                                            mySettingsDirection.visible = false
//                                        }
                                    }
                                    onClicked: {
                                        mySettingsDirection.visible = !mySettingsDirection.visible
                                    }

                                }
                                Rectangle {
                                    id: mySettingsDirection
                                    width: root.width*0.15
                                    height: 200
                                    color: "white"
                                    visible: false
                                    radius: 5
                                    border {
                                        width: 1
                                        color: "#D9D9D9"
                                    }
                                    anchors {
                                        right: parent.right
                                        top: parent.bottom
                                    }
                                    Behavior on visible {
                                        NumberAnimation { duration: 700 }
                                    }

                                    MouseArea {
                                        id: mySettingsDirectionMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onExited: {
//                                            if(!mySettingsMouseArea.containsMouse){
//                                                mySettingsDirection.visible = false
//                                            }
                                        }
//                                        Loader{
//                                            id: loadedStackviewSettings
//                                            anchors.fill: parent
//                                            source: "qrc:/mykitchen/src/qml/setting/settingstack.qml"
//                                        }

                                        StackView {
                                            id: stackView
                                            anchors.fill: parent
                                            initialItem: SettingsView {}
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                id: myProfile
                                height: parent.height
                                width: 20 + myProfileName.width
                                color: "transparent"

                                Image {
                                    id: myProfileUserImage
                                    source: "qrc:/mykitchen/images/user.jpg"
                                    width: 20
                                    height: this.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    fillMode: Image.PreserveAspectFit
                                    visible: true
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: Rectangle {
                                            anchors.fill: parent
                                            width: myProfileUserImage.width
                                            height: myProfileUserImage.height
                                            radius: this.width/2
                                        }
                                    }
                                }
                                Text {
                                    id: myProfileName
                                    text: "quyen"
                                    color: "white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: myProfileUserImage.right
                                    font.pointSize: 10
                                    font.weight: Font.DemiBold
                                    padding: 2
                                }
                                MouseArea {
                                    id: myProfileMouseArea
                                    anchors.fill: myProfile
                                    hoverEnabled: true
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
                                        myDirection.visible = true
                                    }
                                    onExited: {
                                        if(!myDirectionMouseArea.containsMouse){
                                            myDirection.visible = false
                                        }
                                    }
                                    onClicked: {
                                    }

                                }
                                Rectangle {
                                    id: myDirection
                                    width: root.width*0.12
                                    height: 200
                                    color: "white"
                                    visible: false
                                    radius: 5
                                    border {
                                        width: 1
                                        color: "#D9D9D9"
                                    }
                                    anchors {
                                        right: parent.right
                                        top: parent.bottom
                                    }
                                    Behavior on visible {
                                        NumberAnimation { duration: 700 }
                                    }
                                    MouseArea {
                                        id: myDirectionMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onExited: {
                                            if(!myProfileMouseArea.containsMouse){
                                                myDirection.visible = false
                                            }
                                        }
                                        Column {
                                            width: parent.width*0.9
                                            height: 180
                                            anchors.top: parent.top
                                            anchors.centerIn: parent
                                            spacing: 2
                                            Rectangle{
                                                width: parent.width
                                                height: 60
                                                color: "transparent"
                                                radius: 3
                                                Row {
                                                    anchors.fill: parent
                                                    spacing: 10
                                                    leftPadding: 10
                                                    Image {
                                                        height: parent.height*0.4
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/mykitchen/images/my-profile.png"
                                                        fillMode: Image.PreserveAspectFit
                                                    }
                                                    Text {
                                                        text: "Trang của tôi"
                                                        font.pointSize: 11
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: {
                                                        parent.color = "#D9D9D9"
                                                        this.cursorShape = Qt.PointingHandCursor
                                                    }
                                                    onExited: {
                                                        parent.color = "transparent"
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: parent.width
                                                height: 60
                                                color: "transparent"
                                                radius: 3
                                                Row {
                                                    anchors.fill: parent
                                                    spacing: 10
                                                    leftPadding: 10
                                                    Image {
                                                        height: parent.height*0.4
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/mykitchen/images/key.png"
                                                        fillMode: Image.PreserveAspectFit
                                                    }
                                                    Text {
                                                        text: "Đổi mật khẩu"
                                                        font.pointSize: 11
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: {
                                                        parent.color = "#D9D9D9"
                                                        this.cursorShape = Qt.PointingHandCursor
                                                    }
                                                    onExited: {
                                                        parent.color = "transparent"
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: parent.width
                                                height: 60
                                                color: "transparent"
                                                radius: 3
                                                Row {
                                                    anchors.fill: parent
                                                    spacing: 10
                                                    leftPadding: 10
                                                    Image {
                                                        height: parent.height*0.4
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: "qrc:/mykitchen/images/logout.png"
                                                        fillMode: Image.PreserveAspectFit
                                                    }
                                                    Text {
                                                        text: "Thoát"
                                                        font.pointSize: 11
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: {
                                                        parent.color = "#D9D9D9"
                                                        this.cursorShape = Qt.PointingHandCursor

                                                    }
                                                    onExited: {
                                                        parent.color = "transparent"
                                                    }
                                                    onClicked: {
                                                        changeBody();
                                                        changeScreen("qrc:/mykitchen/src/qml/screens/login.qml")
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                            Rectangle{
                                id: myAnnounce
                                height: parent.height
                                width: this.height
                                color: "transparent"

                                Image {
                                    id: imageNptification
                                    source: "qrc:/mykitchen/images/white-notification.png"
                                    width: parent.width*0.35
                                    height: this.width
                                    anchors.centerIn: parent
                                    fillMode: Image.PreserveAspectFit
                                    Text {
                                        id: nameNotification
                                        text: notificationModel.count
                                        anchors.left: imageNptification.right
                                        color: "white"
                                    }
                                }
                                MouseArea {
                                    id: myAnnounceMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        this.cursorShape = Qt.PointingHandCursor
//                                        notificationRect.visible = true
                                    }
                                    onExited: {
                                        if(!notificationMouseArea.containsMouse){
                                            notificationRect.visible = false
                                        }
                                    }
                                    onClicked: {
                                        notificationRect.visible = !notificationRect.visible
                                    }
                                }
                                Rectangle {
                                    id: notificationRect
                                    width: root.width*0.15
                                    height: 350
                                    visible: false
                                    border {
                                        width: 1
                                        color: "#D9D9D9"
                                    }
                                    anchors {
                                        top: parent.bottom
                                        right: parent.right
                                    }
                                    Behavior on visible {
                                        NumberAnimation { duration: 700 }
                                    }
                                    MouseArea {
                                        id: notificationMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onExited: {
                                            if(!myAnnounceMouseArea.containsMouse){
                                                notificationRect.visible = false
                                            }
                                        }
                                        Column {
                                            anchors.fill: parent
                                            spacing: 5
                                            Rectangle{
                                                width: parent.width
                                                height: 50
                                                color: "transparent"
                                                clip: true
                                                Rectangle {
                                                    anchors.fill: parent
                                                    color: "transparent"
                                                    Text {
                                                        text: "Thông báo (" + notificationModel.count + ")"
                                                        font.pointSize: appSettings.fontSize
                                                        font.weight: Font.DemiBold
                                                        anchors.centerIn: parent
                                                    }
                                                }
                                            }
                                            Rectangle {
                                                width: parent.width-4
                                                height: 1
                                                color: "gray"
                                                anchors.horizontalCenter: parent.horizontalCenter
                                            }
                                            Rectangle{
                                                id: rectNotification
                                                width: parent.width
                                                height: 250
                                                color: "transparent"
                                                ListModel {
                                                    id: notificationModel
                                                    ListElement {
                                                        username: "luantv"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về thưởng tết dương lịch 2024"
                                                        dateTime: "08:01:32 - 6 giờ trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv1"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về lịch nghỉ tết dương lịch 2024"
                                                        dateTime: "08:01:32 - 8 giờ trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv2"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về thưởng tết dương lịch 2024"
                                                        dateTime: "08:02:32 - hôm qua"
                                                    }
                                                    ListElement {
                                                        username: "luantv3"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về lịch nghỉ tết âm lịch 2024"
                                                        dateTime: "08:03:32 - 2 ngày trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv4"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về lịch họp đầu năm âm lịch 2024"
                                                        dateTime: "08:04:32 - 3 ngày trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv5"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về kế hoạch phát triển nhân sự năm 2024"
                                                        dateTime: "08:05:32 - 4 ngày trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv6"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về tổ chức các lịch đào tạo kỹ năng mềm để phát triển bản thân cho nhân sự năm 2024"
                                                        dateTime: "08:06:32 - 5 ngày trước"
                                                    }
                                                    ListElement {
                                                        username: "luantv7"
                                                        userlogo: "qrc:/mykitchen/images/user.jpg"
                                                        notification: "Thông báo về lịch nghỉ tết dương lịch 2024"
                                                        dateTime: "08:07:32 - 6 ngày trước"
                                                    }
                                                }
                                                ScrollView {
                                                    anchors.fill: parent
                                                    ListView {
                                                        anchors.fill: parent
                                                        model: notificationModel
                                                        delegate: notificationItem
                                                        spacing: 2
                                                        clip: true
                                                        boundsBehavior: Flickable.StopAtBounds
                                                    }
                                                }
                                                Component {
                                                    id: notificationItem
                                                    Rectangle {
                                                        id: bodyNotification
                                                        width: parent.width*0.95
                                                        height: 60
                                                        color: "transparent"
                                                        radius: 3
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        Row {
                                                            anchors.fill: parent
                                                            spacing: 5
                                                            Rectangle {
                                                                height: parent.height*0.8
                                                                width: this.height
                                                                anchors.verticalCenter: parent.verticalCenter
                                                                color: "transparent"
                                                                Image {
                                                                    id: userLogoItem
                                                                    source: userlogo
                                                                    width: parent.width*0.8
                                                                    anchors.centerIn: parent
                                                                    fillMode: Image.PreserveAspectFit
                                                                    layer.enabled: true
                                                                    layer.effect: OpacityMask {
                                                                        maskSource: Rectangle {
                                                                            anchors.centerIn: parent
                                                                            width: userLogoItem.width
                                                                            height: userLogoItem.height
                                                                            radius: this.width/2
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            ColumnLayout {
                                                                height: parent.height
                                                                width: parent.width-parent.height
                                                                spacing: 1
                                                                Rectangle {
                                                                    Layout.fillWidth: true
                                                                    Layout.fillHeight: true
                                                                    color: "transparent"
                                                                    Layout.preferredHeight: 2
                                                                    Text {
                                                                        anchors {
                                                                            left: parent.left
                                                                            right: parent.right
                                                                            verticalCenter: parent.verticalCenter
                                                                        }
                                                                        text: notification
                                                                        font.pointSize: appSettings.fontSize
                                                                        wrapMode: Text.WordWrap
                                                                        maximumLineCount: 2
                                                                        elide: Text.ElideRight
                                                                    }
                                                                }
                                                                Rectangle {
                                                                    Layout.fillWidth: true
                                                                    Layout.fillHeight: true
                                                                    color: "transparent"
                                                                    Layout.preferredHeight: 1
                                                                    Text {
                                                                        anchors {
                                                                            left: parent.left
                                                                            right: parent.right
                                                                            verticalCenter: parent.verticalCenter
                                                                        }
                                                                        text: dateTime
                                                                        wrapMode: Text.WordWrap
                                                                        font.italic: true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        MouseArea {
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            onEntered: {
                                                                parent.color = "#D9D9D9"
                                                                this.cursorShape = Qt.PointingHandCursor
                                                            }
                                                            onExited: {
                                                                parent.color = "transparent"
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            Rectangle{
                                                width: parent.width
                                                height: 50
                                                color: "green"
                                                Text {
                                                    text: "Xem thêm (+)"
                                                    font.pointSize: appSettings.fontSize
                                                    font.weight: Font.DemiBold
                                                    anchors.centerIn: parent
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered: {
                                                        this.cursorShape = Qt.PointingHandCursor
                                                    }
//                                                        onClicked: {
//                                                            notificationRect.height = rectNotification.height +200
//                                                        }
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                            Rectangle{
                                id: myStatus
                                height: parent.height
                                width: childrenRect.width+10
                                color: "transparent"
                                Text {
                                    text: "Working"
                                    color: "white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pointSize: appSettings.fontSize
                                    font.weight: Font.DemiBold
                                    padding: 10
                                }
                            }
                            Rectangle {
                                id: appsearch
                                width: 250
                                height: parent.height*0.5
                                color: "transparent"
                                anchors {
                                    // left: parent.left
                                    verticalCenter: parent.verticalCenter
                                }
                                radius: 5
                                border {
//                                    color: "#a9a9a9"
                                    color: "white"
                                    width: 1
                                }
                                RowLayout {
                                    width: 250
                                    height: parent.height
                                    anchors.fill: parent.fill
                                    spacing: 0
                                    Image {
                                        Layout.fillHeight:true
                                        Layout.preferredWidth: this.height
                                        Layout.margins: 8
                                        source: "qrc:/mykitchen/images/white-search.png"
                                        fillMode: Image.PreserveAspectFit
                                    }
                                    TextField {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        leftPadding: 0
                                        font.pointSize: appSettings.fontSize
                                        placeholderText: qsTr("Search")
                                        color: "#D9D9D9"
                                        background: Rectangle {
                                            radius: 2
                                            width: parent.width
                                            height: parent.height
                                            border.color: "white"
                                            border.width: 0
                                            color: "transparent"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: navBarLine
                    width: parent.width
                    height: 1
                    color: "gray"
                    anchors.top: navBarRowLayout.bottom
                }
            }
            Rectangle {
                id: body
                visible: true
                Layout.fillWidth: true
                Layout.fillHeight: true
//                Layout.preferredHeight: 10
                color: "transparent"
                RowLayout {
                    id: rowBody
                    visible: true
                    anchors.fill: parent

                    spacing: 0

                    Rectangle{
                        id: hidenBarLeft
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 2
                        color: "transparent"
                    }
                    Rectangle {
                        id: rectGrid
                        color: "transparent"
                        Layout.fillWidth: true
                        Layout.preferredWidth: 6
                        Layout.fillHeight: true
                        Rectangle {
                            id: applist
                            width: parent.width
                            height: parent.height
                            anchors {
                                bottom: parent.bottom
                                topMargin: 50
                            }
                            color: "transparent"
                            ListModel {
                                id: appsModel
                                property int index : 1
//                                ListElement {
//                                    type: "saleListModel"
//                                    name: "Bán hàng"
//                                    pageUrl: "qrc:/mykitchen/src/qml/store/saledaily/sale.qml"
//                                    avisible: false
//                                }
//                                ListElement {
//                                    type: "orderListModel"
//                                    name: "Mua hàng"
//                                    pageUrl: "qrc:/mykitchen/src/qml/store/orderdaily/order.qml"
//                                    avisible: false
//                                }
                                ListElement {
                                    type: "inputListModel"
                                    name: "Nhập kho"
                                    pageUrl: "qrc:/mykitchen/src/qml/store/input/input.qml"
                                    avisible: false
                                }
                                ListElement {
                                    type: "outputListModel"
                                    name: "Xuất kho"
                                    pageUrl: "qrc:/mykitchen/src/qml/store/output/output.qml"
                                    avisible: false
                                }
                                ListElement {
                                    type: "storeListModel"
                                    name: "Kho"
                                    pageUrl: "qrc:/mykitchen/src/qml/store/inventory/storeHome.qml"
                                    avisible: false
                                }
                                ListElement {
                                    type: "suplierListModel"
                                    name: "Nhà cung cấp"
                                    pageUrl: "qrc:/mykitchen/src/qml/store/supplier/supplier.qml"
                                    avisible: false
                                }
                            }
                            GridView {
                                id: appsGrid
                                anchors.fill: parent
                                anchors.topMargin: 170
                                model: appsModel
                                cellWidth: parent.width/6
                                cellHeight: this.cellWidth
                                boundsBehavior: Flickable.StopAtBounds
                                delegate: Rectangle {
                                    width: appsGrid.cellWidth-1
                                    height: appsGrid.cellHeight-1
                                    color: "transparent"
                                    Rectangle{
                                        id: rectApps
                                        width: parent.width/1.5
                                        height: parent.height/1.5
                                        radius: 10
                                        color: Qt.rgba(128/255, 128/255, 128/255, 0.5)
                                        anchors {
                                            centerIn: parent
                                        }
                                        Column {
                                            width: parent.width
                                            height: appImages.height + appNames.height
                                            anchors.centerIn: parent
                                            spacing: 5
                                            Image {
                                                id: appImages
                                                width: parent.width*0.8
                                                source: "qrc:/mykitchen/images/logo.png"
                                                fillMode: Image.PreserveAspectFit
                                                anchors.horizontalCenter: parent.horizontalCenter

                                            }
                                            Text {
                                                id: appNames
                                                text: name;
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                font.pointSize: appSettings.fontSize + 4
                                                color: "white"
                                            }
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onEntered: {
                                                this.cursorShape = Qt.PointingHandCursor
                                                rectApps.width += 30
                                                rectApps.height += 30
                                            }
                                            onExited: {
                                                rectApps.width -= 30
                                                rectApps.height -= 30

                                            }
                                            onClicked: {
                                                menuNavigationText.text = appNames.text
                                                mainContainLoader.source = pageUrl
                                                applist.getTypeCount(type);
                                                changeBody();
//                                                changeScreen("qrc:/mykitchen/src/qml/screens/login.qml")
                                            }
                                        }
                                    }
                                }
                            }
                            function getTypeCount(type) {
                                var count = 0;
                                if(type === "storeListModel"){
                                    menuListing.model = storeListModel;
                                }else if(type === "inputListModel"){
                                    menuListing.model = inputListModel;
                                }else if(type === "outputListModel"){
                                    menuListing.model = outputListModel;
                                }else if(type === "suplierListModel"){
                                    menuListing.model = suplierListModel;
                                }else {
                                    for(var i=0;i<appsGrid.count;i++){
                                        if(type !== appsGrid.model.get(i).type){
                                            menuListing.model = homeListModel;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: hidenBarRight
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 2
                        color: "transparent"
                    }
// main
                }
                Rectangle {
                    id: mainContain
                    visible: false
                    color: "transparent"
                    anchors.fill: parent
                    Layout.fillWidth: true
    //                        Layout.preferredWidth: 10
                    Layout.fillHeight: true

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "white"
                        anchors{
                            leftMargin: 5
                            rightMargin: 5
                            topMargin: 5
                            bottomMargin: 5
                        }
                        Loader {
                            anchors.fill: parent
                            id: mainContainLoader
                        }
                    }
                }
                Rectangle {
                    id: socialNetwork
                    anchors.fill: parent
                    color: "transparent"
                    Rectangle {
                        id: boxContact
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        width: root.width*0.15
                        height: 40
                        color: Qt.rgba(0, 0, 1,0.7)
                        radius: 5
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                contactList.source = "qrc:/mykitchen/src/qml/socialNetwork/ContactList.qml"
                                contactList.item.visible = true
                                boxContact.height = 0
                                contactText.visible = false
                            }
                            onEntered: {
                                this.cursorShape = Qt.PointingHandCursor
                            }
                        }
                        Text {
                            id: contactText
                            anchors.centerIn: parent
                            text: "Danh bạ"
                            font.family: "Helvetica"
                            font.pointSize: 13
                            color: "white"
                        }
                        Loader {
                            id: contactList
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: parent.rightMargin
                            width: parent.width
                            height: mainContain.height
                        }
                    }
                    Rectangle {
                        id: boxMessage
                        anchors.bottom: parent.bottom
                        anchors.right: boxContact.left
                        anchors.rightMargin: 10
                        height: 350
                        width: parent.width
                        color: "transparent"
                        ListModel {
                            id: messModel
                        }
                        RowLayout {
                            spacing: 10
                            anchors.right: parent.right
                            Repeater {
                                model: messModel
                                MessageItem {
                                    width: 300
                                    height: boxMessage.height
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: hideBoxMessage
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 50
                        height: parent.height
                        width: 80
                        color: "transparent"
                        ListModel {
                            id: hideMessModel
                        }
                        ColumnLayout {
                            spacing: 10
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.margins: 10
                            Repeater {
                                model: hideMessModel
                                HideMessageItem {
                                    width: 50
                                    height: 50
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    function changeHome(){
        rowBody.visible = true
        mainContain.visible = false
        if(!mainContain.visible){
            hidenBarLeft.visible = true
            hidenBarRight.visible = true
        }
    }
    function changeBody(){
        rowBody.visible = false
        mainContain.visible = true
        if(mainContain.visible){
            hidenBarLeft.visible = false
            hidenBarRight.visible = false
        }
    }

}

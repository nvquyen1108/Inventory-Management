import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

Popup {
    id: root
    implicitWidth: parent.width < 300 ? 300: parent.width
    implicitHeight: parent.width*1.5 < 400 ? 400: parent.width*1.5
    property var datePicker;
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        anchors.topMargin: 5
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                text: "Month:"
                Layout.leftMargin: 10
            }
            ComboBox {
                id: currentMonth
                Layout.preferredWidth: 60
                Layout.preferredHeight: 40

                model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                contentItem: Label {
                    text: currentMonth.displayText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                delegate: Text {
                    text: currentMonth.valueAt(index)
                    width: currentMonth.width
                    anchors.left:parent.left
                    height: 30
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            this.cursorShape = Qt.PointingHandCursor;
                        }
                        onClicked: {
                            currentMonth.currentIndex = index;
                            currentMonth.popup.close();
                        }
                    }
                }
                onCurrentIndexChanged:{
                    grid.month = currentIndex
                }
                popup: Popup {
                    topMargin: currentMonth.height
                    implicitWidth: currentMonth.width
                    implicitHeight: contentItem.implicitHeight
                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        implicitWidth: contentWidth
                        model: currentMonth.popup.visible ? currentMonth.delegateModel : null
                        boundsBehavior: Flickable.StopAtBounds
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor;
                    }
                    onClicked: {
                        currentMonth.popup.open();
                    }
                }
                Component.onCompleted: currentIndex = find(parseInt(Qt.formatDateTime(new Date(), "MM")))
            }
            Item {
                Layout.preferredWidth: 20
                Layout.preferredHeight: 30
            }
            Text {
                text: "Year:"
            }
            TextField {
                id: yearText
                Layout.preferredWidth: 80
                Layout.preferredHeight: 30
                text: Qt.formatDateTime(new Date(), "yyyy")
                validator: IntValidator {bottom: 1; top: 10000}
                onTextChanged: {
                    grid.year = parseInt(text)
                }
            }
        }
        DayOfWeekRow {
            locale: grid.locale
            Layout.fillWidth: true
        }

        MonthGrid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            month: parseInt(Qt.formatDateTime(new Date(), "MM"))-1
            year: parseInt(Qt.formatDateTime(new Date(), "yyyy"))
            locale: Qt.locale("en_US")
            delegate: Text {
                text: grid.locale.toString(model.date, "d")
                opacity: model.month === grid.month ? 1 : 0.5
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: model.today? "red": "black"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        this.cursorShape = Qt.PointingHandCursor
                    }
                    onClicked: {
                        datePicker = grid.locale.toString(model.date, "yyyy-MM-dd");
                        var yearValue = model.year
                        var monthValue = model.month
                        if(grid.month !== monthValue) {
                            grid.month = monthValue
                        }
                        if(grid.year !== yearValue) {
                            grid.year = yearValue
                        }
                        currentMonth.currentIndex = currentMonth.find(monthValue+1)
                        yearText.text = yearValue
                        this.forceActiveFocus();
                        root.close();
                    }
                }
                required property var model
            }

        }
    }
}

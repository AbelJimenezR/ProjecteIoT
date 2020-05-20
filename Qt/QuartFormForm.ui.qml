import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Controls 2.13
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import io.qt.examples.contenidor 1.0

Item {
    id: element
    property alias textTr: textTr.text
    property alias textTr2: textTr2.text
    property alias map: mapa
    property alias miw: miw
    property alias mpl: mpl
    property alias dialog: dialog
    property alias name: name
    property alias btnCercaTransport: cercaTransport
    property alias tfCercaTransport: tfCercaTransport
    property alias alert: element9

    GridLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        flow: width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

        ColumnLayout {
            Rectangle {
                id: rectangle
                Layout.minimumWidth: 280
                Layout.maximumWidth: 400
                height: 170
                width: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#6bdce4"

                Layout.rowSpan: 2
                Layout.columnSpan: 2

                ColumnLayout {
                    x: 8
                    y: 178
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    Row {

                        Text {
                            color: "#127a3a"
                            text: "CONTENIDOR: "
                            Layout.columnSpan: 2
                        }

                        Text {
                            id: textTr
                            width: 104
                            height: 19
                            color: "#1327b9"
                            Layout.preferredHeight: 19
                            Layout.preferredWidth: 101
                            font.bold: true
                        }
                    }

                    Row {

                        Text {
                            color: "#127a3a"
                            text: "TRANSPORT: "
                            Layout.columnSpan: 2
                        }

                        Text {
                            id: textTr2
                            width: 104
                            height: 19
                            color: "#1327b9"
                            Layout.preferredHeight: 19
                            Layout.preferredWidth: 101
                            font.bold: true
                        }
                    }

                    Row {

                        Text {
                            color: "#127a3a"
                            text: "CERCA TRANSPORT: "
                            Layout.columnSpan: 3
                        }

                        TextField {
                            id: tfCercaTransport
                            width: 104
                            height: 20
                            topPadding: 0
                            Layout.topMargin: -10
                            Layout.leftMargin: -140
                            Layout.preferredHeight: 40
                            Layout.rowSpan: 2
                            Layout.preferredWidth: 89
                            text: ""
                            bottomPadding: 0
                            font.pointSize: 8
                        }
                    }

                    Button {
                        id: cercaTransport
                        text: "Cerca"
                        Layout.topMargin: 30
                        Layout.leftMargin: 90
                        Layout.rowSpan: 2
                        Layout.columnSpan: 2
                    }
                }
            }
        }

        Rectangle {
            height: 400
            width: 350
            Layout.fillWidth: true
            Layout.fillHeight: true

            Map {
                id: mapa
                anchors.fill: parent
                plugin: mapPlugin
                //center: QtPositioning.coordinate(lat(), lon())
                zoomLevel: 10

                MapItemView {
                    id: miw
                    delegate: MapQuickItem {
                        id: mqi
                    }
                }

                MapPolyline {
                    id: mpl
                    line.width: 3
                    line.color: 'green'
                }
            }

            Rectangle {
                id: element9
                x: -116
                y: 220
                anchors.centerIn: parent
                width: 295
                height: 82
                color: "#ffffff"
                border.color: "#e70f0f"
                visible: false
                Text {
                    color: "#e70f0f"
                    text: "Id de transport \n" + "\"" + tfCercaTransport.text + "\"" + "\nno trobat"
                    font.pointSize: 16
                    anchors.centerIn: parent
                }
            }
        }
    }

    Dialog {
        id: dialog
        modal: true
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        Text {
            id: name
            text: qsTr("text")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_x:8;anchors_y:178}
}
##^##*/


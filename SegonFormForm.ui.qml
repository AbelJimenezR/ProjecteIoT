import QtQuick 2.4
import QtQuick.Controls 2.13
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    property alias marker: marker
    property alias map: map
    property alias element9: element9
    property alias button: button
    property alias idCont: idCont
    property alias temp: temp
    property alias producte: producte
    property alias lat: lat
    property alias lon: lon

    Layout.minimumWidth: 200

    ColumnLayout {
        id: mainLayout
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Rectangle {
            id: rectangle
            y: 10
            color: "#6bdce4"
            radius: 0
            Layout.fillHeight: false
            Layout.fillWidth: true
            height: 85

            RowLayout {
                x: -31
                y: 34
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: element2

                    color: "#127a3a"
                    text: qsTr("PRODUCTE:")
                    Layout.leftMargin: 10
                    font.pixelSize: 12
                }

                TextField {
                    id: producte
                    color: "#1327b9"
                    text: contenidorBE.producte.toUpperCase()
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: 100
                    font.bold: true
                    enabled: true
                    font.pixelSize: 12
                }

                Text {
                    id: element4
                    color: "#127a3a"
                    text: qsTr("UBICACIÓ:")
                    Layout.leftMargin: 0
                    font.pixelSize: 12
                }

                GridLayout {
                    id: gridLayout1
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    rowSpacing: 5
                    rows: 2
                    columns: 1

                    Text {
                        id: lat
                        width: 100
                        color: "#1327b9"
                        text: qsTr("Lat: ") + contenidorBE.lat
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                        font.pixelSize: 10
                    }
                    Text {
                        id: lon
                        width: 100
                        color: "#1327b9"
                        text: qsTr("Lon: ") + contenidorBE.lon
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                        font.pixelSize: 10
                    }
                }
            }

            RowLayout {
                x: -21
                y: 12
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: element1
                    color: "#127a3a"
                    text: qsTr("CONTENIDOR:")
                    Layout.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 12
                }

                Text {
                    id: idCont
                    color: "#1327b9"
                    text: contenidorBE.idContenidor
                    enabled: false
                    font.bold: true
                    font.pixelSize: 12
                }

                Text {
                    id: element3
                    color: "#127a3a"
                    text: qsTr("TEMPERATURA:")
                    font.bold: false
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 12
                }

                Text {
                    id: temp
                    color: "#1327b9"
                    text: contenidorBE.temperatura + qsTr(" ºC")
                    font.bold: true

                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 12
                }

                Text {
                    id: element
                    color: "#127a3a"
                    text: qsTr("DARRERA LOC:")
                    font.pixelSize: 12
                }

                Text {
                    id: element5
                    color: "#1327b9"
                    text: contenidorBE.data
                    font.bold: true
                    font.pixelSize: 12
                }
            }
        }

        Rectangle {
            id: rectangle1
            Layout.topMargin: 60
            Layout.fillHeight: true
            Layout.fillWidth: true
            height: 200
            color: "#00000000"
            Plugin {
                id: mapPlugin
                name: "osm"
            }

            Map {
                id: map
                anchors.topMargin: -64
                anchors.fill: parent
                plugin: mapPlugin
                zoomLevel: 10

                MapQuickItem {
                    id: marker
                    anchorPoint.x: image.width / 2
                    anchorPoint.y: image.height

                    sourceItem: Image {
                        id: image
                        width: 40
                        height: 50
                        source: "qrc:/imatges/marker.png"
                    }
                }

                Rectangle {
                    id: element9
                    anchors.centerIn: parent
                    width: 295
                    height: 40
                    color: "#ffffff"
                    border.color: "#e70f0f"
                    visible: false
                    Text {
                        color: "#e70f0f"
                        text: "Contenidor no registrat"
                        font.pointSize: 16
                        anchors.centerIn: parent
                    }
                }

                Button {
                    id: button
                    visible: false
                    x: 270
                    y: 0
                    text: qsTr("Modifica Producte")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        color: button.down ? "#0dd40d" : "#93F362"
                        border.color: "#26282a"
                        border.width: 1
                        radius: 4
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:54;anchors_y:44}D{i:18;anchors_width:636}
D{i:20;anchors_width:636}D{i:19;anchors_width:636}D{i:17;anchors_width:636}
}
##^##*/


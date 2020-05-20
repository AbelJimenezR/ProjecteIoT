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
    property alias idCont: idCont
    property alias temp: temp
    property alias producte: producte
    property alias demanaContenidorHistoric: button1
    property alias textData: element5
    property alias idTransport: idTransport
    property alias ptNouIdTransport: ptNouIdTransport
    property alias pBtnNouTransport: pBtnNouTransport
    property alias ptfNouProducte: ptfNouProducte
    property alias popup: popup

    GridLayout {
        anchors.fill: parent

        flow: width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
        ColumnLayout {
            Rectangle {
                Layout.minimumWidth: 280
                Layout.maximumWidth: 400
                id: rectangle
                height: 170
                width: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#6bdce4"
                GridLayout {

                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    rows: 6
                    columns: 2
                    Text {
                        id: element1
                        color: "#127a3a"
                        text: qsTr("CONTENIDOR:")
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
                        id: element2
                        color: "#127a3a"
                        text: qsTr("PRODUCTE:")
                        font.pixelSize: 12
                    }

                    Text {
                        id: producte
                        color: "#1327b9"
                        text: contenidorBE.producte.toUpperCase()
                        font.bold: true
                        font.pixelSize: 12
                    }

                    Text {
                        id: element4
                        color: "#127a3a"
                        text: qsTr("ID TRANSPORT:")
                        font.pixelSize: 12
                    }

                    Text {
                        id: idTransport
                        color: "#1327b9"
                        text: contenidorBE.idTransport
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
                    Button {
                        id: button2
                        // @disable-check M222
                        onClicked: popup.open()
                        text: qsTr("Nou Transport")
                    }

                    Button {
                        id: button1

                        text: qsTr("Veure Ruta")
                        //anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        Rectangle {
            height: 400
            width: 350
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "green"
            Plugin {
                id: mapPlugin
                name: "osm"
            }

            Map {
                id: map
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
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
            }
        }
        Popup {
            id: popup
            x: 100
            y: 100
            width: 200
            height: 200
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            contentItem: ColumnLayout {
                height: 120
                Text {
                    id: name
                    text: "PRODUCTE: "
                }

                TextField {
                    id: ptfNouProducte
                    y: 30
                    width: 140
                    text: ""
                }

                Text {
                    id: ptNouIdTransport
                }
                Button {
                    id: pBtnNouTransport
                    text: "Nou"
                    y: 50
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


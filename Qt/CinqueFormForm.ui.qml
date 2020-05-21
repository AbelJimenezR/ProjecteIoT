import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import io.qt.examples.contenidor 1.0

Item {

    property alias btnConnecta: connecta
    property alias tfUser: tFUser
    property alias tfPass: tFPass
    Rectangle {
        id: rectangle
        color: "#80f2f2"
        anchors.fill: parent

        Button {
            id: connecta
            x: 270
            y: 344
            text: qsTr("Connecta")
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: element
            x: 308
            y: 76
            color: "#0c06a8"
            text: qsTr("BENVINGUT")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 35
        }

        Text {
            id: element1
            x: 308
            y: 139
            text: qsTr("USUARI")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        TextField {
            id: tFUser
            x: 220
            y: 166
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: element2
            x: 308
            y: 233
            text: qsTr("CONTRASENYA")
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        TextField {
            id: tFPass
            x: 220
            y: 263
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


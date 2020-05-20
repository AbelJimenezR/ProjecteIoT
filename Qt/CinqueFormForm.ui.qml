import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import io.qt.examples.contenidor 1.0

Item {

    property alias btnConnecta: connecta
    Rectangle {
        id: rectangle
        color: "#80f2f2"
        anchors.fill: parent

        Button {
            id: connecta
            x: 270
            y: 220
            text: qsTr("Connecta")
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
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:200;anchors_width:200;anchors_x:114;anchors_y:158}
}
##^##*/


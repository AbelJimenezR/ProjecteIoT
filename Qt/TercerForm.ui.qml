import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.5

Item {
    property alias btnCrea: button
    property alias dialog: dialog
    property alias tfProducte: tfProducte
    property alias tfIdCont: tfIdCont

    id: element1

    Rectangle {
        id: rectangle
        color: "#e7fafe"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 2
        anchors.topMargin: 0
        anchors.fill: parent

        Button {
            id: button
            anchors.centerIn: parent
            text: qsTr("AFEGIR")
            anchors.verticalCenterOffset: 60
            anchors.horizontalCenterOffset: 0
        }
    }

    GridLayout {
        x: 162
        y: 64
        width: 317
        height: 132
        anchors.verticalCenterOffset: -100
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        rows: 2
        columns: 2
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: element
            text: qsTr("MAT. CONTENIDOR:")
            font.bold: false
            font.pixelSize: 16
        }

        TextField {
            id: tfIdCont
            placeholderText: "i.e. CT001"
            text: ""
            Layout.fillWidth: true
            validator: RegExpValidator {
                regExp: /[Cc]{1}[Tt]{1}[0-9]{3}/
            }
        }

        Text {
            id: element2
            text: qsTr("PRODUCTE:")
            font.pixelSize: 16
        }

        TextField {
            id: tfProducte
            text: ""
            Layout.fillWidth: true
        }
    }

    Dialog {
        id: dialog
        modal: true
        title: "El contenidor ja existeix"
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:270;anchors_y:285}D{i:1;anchors_height:336;anchors_width:303;anchors_x:176;anchors_y:66}
D{i:3;anchors_height:132;anchors_width:317;anchors_x:162;anchors_y:86}
}
##^##*/


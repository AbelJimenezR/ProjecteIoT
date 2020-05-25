import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.3

Item {

    property alias btnNouContenidor: btnNouContenidor
    property alias view: view

    ColumnLayout {

        id: mainLayout
        anchors.fill: parent

        ListView {

            id: view
            Layout.topMargin: 50
            model: contenidorBE.listModel
            Layout.minimumHeight: 25
            Layout.fillHeight: true
            Layout.fillWidth: true
            cacheBuffer: 100
            spacing: 10
        }
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        height: 45
        color: "#6bdce4"
        Layout.fillWidth: true
        width: parent.width

        Button {
            id: btnNouContenidor
            width: 129
            height: 28
            text: "Nou Contenidor"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 9
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_x:8;anchors_y:9}
}
##^##*/


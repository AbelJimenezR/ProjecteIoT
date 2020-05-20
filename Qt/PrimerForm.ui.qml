import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {

    //property alias buttonNou: newCont
    //property alias btnConnecta: connecta
    property alias view: view
    ColumnLayout {

        id: mainLayout
        anchors.fill: parent

        ListView {

            id: view
            model: contenidorBE.listModel
            Layout.minimumHeight: 25
            Layout.fillHeight: true
            Layout.fillWidth: true
            cacheBuffer: 100
            spacing: 10
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/


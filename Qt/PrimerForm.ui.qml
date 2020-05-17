import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    property alias buttonNou: newCont
    property alias btnConnecta: connecta
    property alias view: view

    ColumnLayout {

        id: mainLayout
        anchors.fill: parent

        //anchors.margins: margin
        Rectangle {
            color: "#6bdce4"
            Layout.fillWidth: true
            height: 40
            z: 2
            RowLayout {
                id: rowLayout
                anchors.fill: parent
                anchors.centerIn: parent
                TextField {
                    placeholderText: "Type here.."
                    Layout.fillWidth: true
                    font.pointSize: 12
                    style: TextFieldStyle {
                        textColor: "black"
                        background: Rectangle {
                            radius: 5
                            implicitWidth: 100
                            implicitHeight: 30
                            border.color: "#6bdce4"
                            border.width: 1
                        }
                    }


                    /* onTextChanged: {
 filterModel.setFilterString(text);
 }*/
                }

                Button {
                    id: newCont
                    text: "New"
                    enabled: false


                    /*onCheckedChanged:{
 filterModel.setSortOrder(checked)
 }*/
                }
                Button {
                    id: connecta
                    text: "Connecta"


                    /*onCheckedChanged:{
 filterModel.setSortOrder(checked)
 }*/
                }
            }
        }

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


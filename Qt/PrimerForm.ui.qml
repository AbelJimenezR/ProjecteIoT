import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    property alias buttonNou: newCont
    property alias btnConnecta: connecta

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

            delegate: Rectangle {

                width: parent.width
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter
                height: 40
                color: Qt.lighter("#6bdce4", 0.8)
                Text {
                    id: model
                    text: modelData
                    font.pointSize: 12
                    color: "#FFFFFF"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    id: mouse_area1
                    z: 1
                    hoverEnabled: true
                    anchors.fill: parent
                    // @disable-check M223
                    onClicked: {
                        // @disable-check M222
                        contenidorBE.setIdContenidor(model.text)
                        // @disable-check M222
                        contenidorBE.subscribe("repContenidor")
                        // @disable-check M222
                        contenidorBE.subscribe("repContenidorInici")
                        // @disable-check M222
                        contenidorBE.repContenidor(model.text)
                        // @disable-check M222
                        //contenidorBE.repContenidor(model.text)

                        // @disable-check M222
                        myStackView.push(segonForm)
                    }
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


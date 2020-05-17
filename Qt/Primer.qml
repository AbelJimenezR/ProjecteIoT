import QtQuick 2.4
import io.qt.examples.contenidor 1.0

PrimerForm {

    view {

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
                onClicked: {
                    contenidorBE.setIdContenidor(model.text)
                    contenidorBE.subscribe("repContenidor")
                    contenidorBE.subscribe("repContenidorInici")
                    contenidorBE.demanaContenidor(model.text)

                    //contenidorBE.repContenidor(model.text)
                    myStackView.push(segonForm)
                }
            }
        }
    }

    anchors.fill: parent

    buttonNou.onClicked: {
        myStackView.push(tercerForm)
    }

    btnConnecta.onClicked: {
        if (contenidorBE.subscribe("repContenidors")
                && contenidorBE.demanaLlistaContenidors()) {
            ledConnect.color = '#00ff00'
            btnConnecta.enabled = false
            buttonNou.enabled = true
        }
    }
}

import QtQuick 2.4
import io.qt.examples.contenidor 1.0

PrimerForm {

    anchors.fill: parent

    buttonNou.onClicked: {
        myStackView.push(tercerForm)
    }

    btnConnecta.onClicked: {
        if (contenidorBE.subscribe("repContenidors")
                && contenidorBE.repContenidors()) {
            ledConnect.color = '#00ff00'
            btnConnecta.enabled = false
            buttonNou.enabled = true
        }
    }
}

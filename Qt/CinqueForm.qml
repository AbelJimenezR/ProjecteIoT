import QtQuick 2.4
import io.qt.examples.contenidor 1.0

CinqueFormForm {

    btnConnecta.onClicked: {

        contenidorBE.setCredentials(tfUser.text, tfPass.text)
        contenidorBE.connecta()
        if (contenidorBE.subscribe("repContenidors")
                && contenidorBE.demanaInici()) {

            myStackView.push(primerForm)
            ledConnect.color = '#00ff00'
        }
    }
}

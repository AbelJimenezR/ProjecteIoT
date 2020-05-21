import QtQuick 2.4
import io.qt.examples.contenidor 1.0

CinqueFormForm {


    /*tfUser.onTextEdited: {
        contenidorBE.setCredentials(tfUser.text, tfPass.text)

    }

    tfPass.onTextEdited: {
        contenidorBE.setCredentials(tfUser.text, tfPass.text)
        contenidorBE.idContenidor = 5
    }*/
    btnConnecta.onClicked: {

        contenidorBE.setCredentials(tfUser.text, tfPass.text)
        contenidorBE.connecta()
        if (contenidorBE.subscribe("repContenidors")
                && contenidorBE.demanaLlistaContenidors()) {

            myStackView.push(primerForm)
            ledConnect.color = '#00ff00'
        }
    }
}

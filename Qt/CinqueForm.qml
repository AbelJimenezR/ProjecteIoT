import QtQuick 2.4
import io.qt.examples.contenidor 1.0

CinqueFormForm {


    /*buttonNou.onClicked: {
        myStackView.push(tercerForm)
    }*/
    btnConnecta.onClicked: {
        if (contenidorBE.subscribe("repContenidors")
                && contenidorBE.demanaLlistaContenidors()) {

            myStackView.push(primerForm)

            ledConnect.color = '#00ff00'
        }
    }
}

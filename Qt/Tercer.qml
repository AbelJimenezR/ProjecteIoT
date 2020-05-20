import QtQuick 2.4
import io.qt.examples.contenidor 1.0

TercerForm {

    btnCrea.onClicked: {
        if (!contenidorBE.comprovaContenidor(tfIdCont.text.toUpperCase())) {
            if (tfProducte.text != "") {
                contenidorBE.afegirContenidor(tfIdCont.text.toUpperCase(),
                                              tfProducte.text.toUpperCase())
                myStackView.pop()
            } else {
                dialog.title = "Introdueix un producte"
                dialog.open()
            }
        } else {
            dialog.open()
        }
    }
}

import QtQuick 2.4
import QtPositioning 5.6

SegonFormForm {

    demanaContenidorHistoric.onClicked: {
        contenidorBE.subscribe("repContenidorHistoric")
        contenidorBE.demanaContenidorHistoric("CT001")

    }

    producte.onTextEdited: {
        console.log(contenidorBE.producte)
        console.log(producte.text)

        if (producte.text.toLowerCase() == contenidorBE.producte
                || producte.text.toUpperCase() == contenidorBE.producte) {
            button.visible = false
        } else {
            button.visible = true
        }
    }

    button.onClicked: {
        if (contenidorBE.editaContenidor(contenidorBE.idContenidor,
                                         producte.text,
                                         contenidorBE.temperatura,
                                         contenidorBE.lat, contenidorBE.lon)) {
            button.visible = false
        }
    }

    anchors.fill: parent
    map {

        center: {
            if (contenidorBE.lat == "") {
                element9.visible = true
                marker.visible = false
            } else {
                element9.visible = false
                marker.visible = true

                QtPositioning.coordinate(contenidorBE.lat, contenidorBE.lon)
            }
        }
    }

    marker {
        coordinate: QtPositioning.coordinate(contenidorBE.lat, contenidorBE.lon)
    }
}

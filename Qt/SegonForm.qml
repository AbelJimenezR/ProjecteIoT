import QtQuick 2.4
import QtPositioning 5.6

SegonFormForm {

    ptNouIdTransport.text: "Nou transport: " + (parseInt(
                                                    contenidorBE.idTransport) + 1)

    // anchors.fill: parent
    demanaContenidorHistoric.onClicked: {
        contenidorBE.subscribe("repContenidorHistoric")
        contenidorBE.demanaContenidorHistoric(idCont.text, idTransport.text)
        myStackView.push(quartForm)
    }

    pBtnNouTransport.onClicked: {

        if (contenidorBE.editaContenidor(contenidorBE.idContenidor,
                                         ptfNouProducte.text,
                                         contenidorBE.temperatura,
                                         contenidorBE.lat, contenidorBE.lon,
                                         (parseInt(
                                              contenidorBE.idTransport) + 1))) {
            popup.close()
            myStackView.pop()
        }
    }

    map {

        center: {
            if (contenidorBE.lat == "") {
                element9.visible = true
                demanaContenidorHistoric.visible = false
                textData.text = ""
            } else {
                element9.visible = false
                marker.visible = true
                demanaContenidorHistoric.visible = true
                textData.text = formatData(contenidorBE.data)

                QtPositioning.coordinate(contenidorBE.lat, contenidorBE.lon)
            }
        }
    }

    marker {
        coordinate: QtPositioning.coordinate(contenidorBE.lat, contenidorBE.lon)
    }

    function formatData(time) {

        var d = new Date(time)
        var t = d.getDate(
                    ) + "-" + (d.getMonth() + 1) + "-" + d.getFullYear() + " " + d.getHours(
                    ) + ":" + d.getMinutes()

        return t
    }
}

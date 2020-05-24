import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Controls 2.13
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import io.qt.examples.contenidor 1.0

QuartFormForm {

    textTr: obteIdTr()[0]

    textTr2: obteIdTr()[1]

    btnCercaTransport.onClicked: {
        searchModel.clear()
        contenidorBE.demanaContenidorHistoric(contenidorBE.idContenidor,
                                              tfCercaTransport.text)
    }
    Plugin {
        id: mapPlugin
        name: "osm"
    }

    ListModel {
        id: searchModel
    }

    map {
        center: {
            function lat() {
                var s = contenidorBE.listModelContenidors.length
                var t = contenidorBE.listModelContenidors[s - 1].split(",")
                return t[0]
            }
            function lon() {
                var s = contenidorBE.listModelContenidors.length
                var t = contenidorBE.listModelContenidors[s - 1].split(",")
                return t[1]
            }
            QtPositioning.coordinate(lat(), lon())
        }
    }

    miw {
        model: c()
        delegate: MapQuickItem {
            coordinate: QtPositioning.coordinate(lat, lon)
            anchorPoint.x: image.width / 2
            anchorPoint.y: image.height
            sourceItem: Image {
                id: image
                width: 40
                height: 50
                source: "qrc:/imatges/marker.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        popup(idCont, temp, transport, product, time)
                    }
                }
            }
        }
    }

    mpl {
        path: f()
    }

    //AFEGEIX COORDENADES AL MAP POLY LINE
    function f() {
        var s = mpl.path
        s = []
        for (var x = 0; x < contenidorBE.listModelContenidors.length; x++) {
            var t = contenidorBE.listModelContenidors[x].split(",")

            s.push({
                       "latitude": t[0],
                       "longitude": t[1]
                   })
            if (s.isEmpty) {
                console.log("w")
            }
        }

        return s
    }

    function c() {
        if (contenidorBE.listModelContenidors.length == 0) {
            alert.visible = true
        } else {
            alert.visible = false
        }

        for (var x = 0; x < contenidorBE.listModelContenidors.length; x++) {
            var t = contenidorBE.listModelContenidors[x].split(",")

            searchModel.append({
                                   "lat": t[0],
                                   "lon": t[1],
                                   "temp": t[2],
                                   "idCont": t[3],
                                   "transport": t[4],
                                   "product": t[5],
                                   "time": t[6]
                               })
        }
        return searchModel
    }

    function obteIdTr() {
        var x = []
        var s = contenidorBE.listModelContenidors.length
        var t = contenidorBE.listModelContenidors[s - 1].split(",")
        x.push(t[3].toString())
        x.push(t[4])

        return x
    }

    function popup(idCont, temp, transport, product, time) {
        dialog.title = idCont

        name.text = "Transport: " + transport + "\nProducte: " + product
                + "\nTemperatura: " + temp + "\nData: " + formatData(time)
        dialog.open()
    }

    function formatData(time) {

        var d = new Date(time)
        var t = d.getDate(
                    ) + "-" + (d.getMonth() + 1) + "-" + d.getFullYear() + " " + d.getHours(
                    ) + ":" + d.getMinutes()

        return t
    }
}

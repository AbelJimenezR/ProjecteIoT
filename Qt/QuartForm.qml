import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Controls 2.13
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import io.qt.examples.contenidor 1.0

QuartFormForm {

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    ListModel {
        id: searchModel
    }

    Map {
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

        id: map

        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(lat(), lon())
        zoomLevel: 10

        MapItemView {
            model: searchModel
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
                        onClicked: popup(idCont, temp)
                    }
                }
            }
        }
    }

    Component.onCompleted: {

        for (var x = 0; x < contenidorBE.listModelContenidors.length; x++) {
            var t = contenidorBE.listModelContenidors[x].split(",")

            searchModel.append({
                                   "lat": t[0],
                                   "lon": t[1],
                                   "temp": t[2],
                                   "idCont": t[3]
                               })
        }
    }

    Dialog {
        id: dialog
        modal: true
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        Text {
            id: name
            text: qsTr("text")
        }
    }

    function popup(idCont, temp) {
        dialog.title = idCont
        name.text = "Temperatura: " + temp + "\n" + "Temperatura: " + temp
        dialog.open()
    }

    //view.onModelChanged:
}

import QtQuick 2.13
import QtQuick.Controls 2.13
import QtLocation 5.6
import QtPositioning 5.6
import io.qt.examples.contenidor 1.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "CONTENIDORS"
    minimumWidth: 295
    minimumHeight: 400

    Contenidor {
        id: contenidorBE
        onListModelContenidorsChange: {

            // myStackView.push(quartForm)
        }
    }

    header: ToolBar {
        id: tb
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("<<")
                onClicked: myStackView.pop()
            }

            Label {
                id: lb
                text: "CONTENIDORS"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            Rectangle {
                id: ledConnect
                color: '#ff0000'
                height: 20
                width: 20
                radius: 25
            }
        }
    }

    StackView {

        id: myStackView
        anchors.fill: parent
        initialItem: Component {

            id: cinqueForm
            CinqueForm {}
        }

        Component {
            id: segonForm
            SegonForm {}
        }

        Component {
            id: tercerForm
            Tercer {}
        }

        Component {

            id: quartForm
            QuartForm {}
        }

        Component {

            id: primerForm
            Primer {}
        }
    }
}

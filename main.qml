import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts
import Pyside_Bridge 1.0

ApplicationWindow {
    id: window
    width: 450
    height: 700
    visible: true

    Pyside_Bridge_class {
        id: bridge
        // pyside_chat_data
    }

    Rectangle {
        anchors.fill: parent
        color: "white"

        Column {
            anchors.centerIn: parent
            spacing: 20
            width: parent.width * 0.9

            Text {
                id: dictText
                text: "Press button to fetch data"
                font.pixelSize: 18
                color: "black"
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            Button {
                text: "Press to fetch"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    let jsonString = JSON.stringify(bridge.pyside_chat_data, null, 2); // Pretty print JSON
                    dictText.text = jsonString;
                    console.log(jsonString);
                }
            }
        }
    }

}
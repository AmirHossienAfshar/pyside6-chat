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
        // pyside_chat_data2
    }

    // Rectangle {
    //     anchors.fill: parent
    //     color: "white"

    //     Column {
    //         anchors.centerIn: parent
    //         spacing: 20
    //         width: parent.width * 0.9

    //         Text {
    //             id: dictText
    //             text: JSON.stringify(bridge.pyside_chat_data, null, 2) // Automatically updates when pyside_chat_data changes
    //             font.pixelSize: 18
    //             color: "black"
    //             wrapMode: Text.Wrap
    //             horizontalAlignment: Text.AlignHCenter
    //             width: parent.width
    //         }

    //         Button {
    //             text: "Press to fetch"
    //             anchors.horizontalCenter: parent.horizontalCenter
    //             onClicked: {
    //                 let jsonString = JSON.stringify(bridge.pyside_chat_data, null, 2); // Pretty print JSON
    //                 dictText.text = jsonString;
    //                 console.log(jsonString);
    //             }
    //         }
    //     }
    // }

    ListView {
        id: chatListView
        anchors.fill: parent
        // model: bridge.pyside_chat_data  // Updated model
        model: ["hi", "how you doin", "hellll"]

        delegate: Column {
            spacing: 6

            Row {
                id: messageRow
                spacing: 6
                anchors.right: model.sender === "mymsg" ? parent.right : undefined
                anchors.left: model.sender === "othermsg" ? parent.left : undefined

                Rectangle {
                    width: Math.min(messageText.implicitWidth + 24, chatListView.width - 40)
                    height: messageText.implicitHeight + 24
                    radius: 15
                    color: model.sender === "mymsg" ? "lightgrey" : "steelblue"

                    Label {
                        id: messageText
                        text: model.message
                        color: model.sender === "mymsg" ? "black" : "white"
                        anchors.fill: parent
                        anchors.margins: 12
                        wrapMode: Label.Wrap
                    }
                }
            }
        }
    }

}

// well, lets say that I want that thing to be added to a model of a list view. how to do that?
// that model, should be carefully check if the msg is like this:

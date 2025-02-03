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

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.9
            spacing: 2

            GroupBox {
                title: "Chatroom"
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width
                ListView {
                    id: chatListView
                    anchors.fill: parent
                    model: bridge.pyside_chat_list

                    delegate: Column {
                        property bool isMine: modelData.startsWith("mine: ")

                        anchors.right: isMine ? chatListView.contentItem.right : undefined
                        anchors.left: !isMine ? chatListView.contentItem.left : undefined
                        spacing: 6

                        Row {
                            id: messageRow
                            spacing: 6
                            anchors.right: isMine ? parent.right : undefined
                            anchors.left: !isMine ? parent.left : undefined

                            Rectangle {
                                width: Math.min(messageText.implicitWidth + 24, chatListView.width - 40)
                                height: messageText.implicitHeight + 24
                                radius: 15
                                color: isMine ? "lightgrey" : "steelblue"

                                Label {
                                    id: messageText
                                    text: modelData.substring(modelData.indexOf(": ") + 2)
                                    color: isMine ? "black" : "white"
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    wrapMode: Label.Wrap
                                }
                            }
                        }

                        Label {
                            id: timestampText
                            text: "" // You can populate this with dynamic timestamps if needed
                            color: "lightgrey"
                            anchors.right: isMine ? parent.right : undefined
                            anchors.left: !isMine ? parent.left : undefined
                            font.pixelSize: 10
                        }
                    }
                }
            }
        }
        RowLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.1
            TextArea {
                id: messageField
                Layout.fillWidth: true
                Layout.fillHeight: true
                placeholderText: qsTr("Compose message")

                wrapMode: TextArea.Wrap
            }

            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: sendButton
                text: qsTr("Send")
                enabled: messageField.length > 0
                onClicked: {
                    // pyside_chatroom_class.append_message(messageField.text)
                    messageField.text = ""
                    // parseChatData()
                    // if (parsedChatModel.count > 0) {
                    //     console.log("sentBy =", parsedChatModel.get(parsedChatModel.count - 1).message)
                    // }
                    // chatListView.model = parsedChatModel     
                    console.log(bridge.pyside_chat_data)
                }
            }
        }
    }
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
                // ListView {
                //     id: chatListView
                //     anchors.fill: parent
                //     model: bridge.pyside_chat_data
                //     // model: ["hello", "how u doin", "im fine~!"]

                //     delegate: Column {
                //         // Use index % 2 to determine alignment
                //         anchors.right: index % 2 === 0 ? chatListView.contentItem.right : undefined
                //         anchors.left: index % 2 !== 0 ? chatListView.contentItem.left : undefined
                //         spacing: 6

                //         Row {
                //             id: messageRow
                //             spacing: 6
                //             anchors.right: index % 2 === 0 ? parent.right : undefined
                //             anchors.left: index % 2 !== 0 ? parent.left : undefined

                //             Rectangle {
                //                 width: Math.min(messageText.implicitWidth + 24, chatListView.width - 40)
                //                 height: messageText.implicitHeight + 24
                //                 radius: 15
                //                 color: index % 2 === 0 ? "lightgrey" : "steelblue"

                //                 Label {
                //                     id: messageText
                //                     text: modelData
                //                     color: index % 2 === 0 ? "black" : "white"
                //                     anchors.fill: parent
                //                     anchors.margins: 12
                //                     wrapMode: Label.Wrap
                //                 }
                //             }
                //         }

                //         Label {
                //             id: timestampText
                //             text: "" // You can populate this with dynamic timestamps if needed
                //             color: "lightgrey"
                //             anchors.right: index % 2 === 0 ? parent.right : undefined
                //             anchors.left: index % 2 !== 0 ? parent.left : undefined
                //             font.pixelSize: 10
                //         }
                //     }
                // }
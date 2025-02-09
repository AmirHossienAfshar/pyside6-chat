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
        // pyside_chat_list
        // pyside_edithing_text
        // pyside_is_edithing
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.85
            spacing: 2
            MessageBoard {
                id: messageBoard
                model: bridge.pyside_chat_list
            }
        }
        RowLayout {
            // compose message row layout
            visible: !bridge.pyside_is_edithing
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: parent.height * 0.1
            TextArea {
                id: messageField
                Layout.fillWidth: true
                Layout.fillHeight: true
                placeholderText: qsTr("Compose message")
                wrapMode: TextArea.Wrap
                verticalAlignment: Text.AlignVCenter  // Center text vertically
                horizontalAlignment: Text.AlignHCenter  // Center text horizontally
                padding: 12  // Optional: Add some padding for better spacing
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        if (event.modifiers & Qt.ShiftModifier) {
                            sendButton.click() // Shift + Enter → Send message
                        } else {
                            messageField.insert(messageField.cursorPosition, "\n") // Enter → New Line
                        }
                        event.accepted = true // Prevent default behavior
                    }
                }
            }
            Button {
                // Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.2
                Layout.fillHeight: true
                id: sendButton
                text: qsTr("Send")
                enabled: messageField.length > 0
                onClicked: {
                    bridge.set_new_msg(messageField.text)
                    messageField.text = ""
                    // console.log(bridge.pyside_chat_list)
                }
            }
        }
        RowLayout {
            // edith message row layout
            visible: bridge.pyside_is_edithing
            Layout.preferredWidth: parent.width * 0.8
            Layout.preferredHeight: parent.height * 0.1
            TextArea {
                id: messageField_edith
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: bridge.pyside_edithing_text
                wrapMode: TextArea.Wrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                padding: 12
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        if (event.modifiers & Qt.ShiftModifier) {
                            sendButton_edith.click() // Shift + Enter → edith message
                        } else {
                            messageField_edith.insert(messageField_edith.cursorPosition, "\n") // Enter → New Line
                        }
                        event.accepted = true // Prevent default behavior
                    }
                }
            }
            Button {
                Layout.preferredWidth: parent.width * 0.1
                Layout.fillHeight: true
                id: sendButton_edith
                text: qsTr("edith")
                enabled: messageField_edith.length > 0
                onClicked: {
                    // bridge.pyside_is_edithing = false // not neccessary because the bridge will do it.
                    bridge.edith_msg(messageField_edith.text)

                }
            }
            Button {
                Layout.preferredWidth: parent.width * 0.1
                Layout.fillHeight: true
                id: sendButton_edith_cancel
                text: qsTr("cancel")
                onClicked: {
                    bridge.pyside_is_edithing = false
                }
            }
        }
    }
}

        // // this part is going to come in handy when the reply feature added.
        // RowLayout{
        //     // visible: false
        //     Layout.preferredWidth: parent.width
        //     Layout.preferredHeight: parent.height * 0.05
            
        //     Rectangle {
        //         Layout.preferredWidth: parent.width * 0.95
        //         Layout.fillHeight: true
        //         border.width: 1
        //         Text {
        //             text: qsTr("Chatroom")
        //             anchors.centerIn: parent
        //         }
        //     }
        //     Button {
        //         Layout.preferredWidth: parent.width * 0.05
        //         Layout.fillHeight: true
        //         text: qsTr("×")
        //         onClicked: {
        //             bridge.clear_chat()
        //         }
        //     }
        // }
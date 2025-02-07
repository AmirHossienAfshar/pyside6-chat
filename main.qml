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
        // set_new_msg
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.9
            spacing: 2
            
            MessageBoard {
                id: messageBoard
                model: bridge.pyside_chat_list
            }
        }

        RowLayout {
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
    }
}
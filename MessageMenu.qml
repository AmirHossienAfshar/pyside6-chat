import QtQuick 6.5
import QtQuick.Controls 6.5
import Pyside_Bridge 1.0

Item {
    id: messageArea
    property bool is_Mine: false
    property string messageContent: ""

    anchors.fill: parent


    Pyside_Bridge_class {
        id: bridge
        // pyside_chat_list
        // set_new_msg
        // menu_copy_msg
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton) {
                if (is_Mine) {
                    messageMenuMine.x = mouse.x
                    messageMenuMine.y = mouse.y + 10
                    messageMenuMine.open()
                } else {
                    messageMenuOther.x = mouse.x
                    messageMenuOther.y = mouse.y + 10
                    messageMenuOther.open()
                }
            }
        }

        Menu {
            id: messageMenuMine
            MenuItem {
                text: qsTr("Reply")
                onTriggered: {
                    console.log("Reply to message: " + messageContent)
                }
            }
            MenuItem {
                text: qsTr("Edit")
                onTriggered: {
                    console.log("Edit message: " + messageContent)
                }
            }
            MenuItem {
                text: qsTr("Copy")
                onTriggered: {
                    console.log("Copy message: " + messageContent)
                    bridge.menu_copy_msg(messageContent)
                }
            }
        }

        Menu {
            id: messageMenuOther
            MenuItem {
                text: qsTr("Reply")
                onTriggered: {
                    console.log("Reply to message: " + messageContent)
                }
            }
            MenuItem {
                text: qsTr("Copy")
                onTriggered: {
                    console.log("Copy message: " + messageContent)
                    bridge.menu_copy_msg(messageContent)
                }
            }
        }
    }
}

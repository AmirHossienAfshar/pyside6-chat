import QtQuick 6.5
import QtQuick.Controls 6.5
import Message_Menu 1.0

Item {
    id: messageArea
    property bool is_Mine: false
    property string messageContent: ""
    property int messageIndex: -1
    property string messageTimeStamp: "00:00"

    anchors.fill: parent

    Message_Menu_Class {
        id: bridge
        // menu_edith_msg
        // menu_copy_msg
        // menu_edith_msg_index
        // menu_edith_msg_time
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        // onClicked: {
        //     if (mouse.button === Qt.RightButton) {
        //         if (is_Mine) {
        //             messageMenuMine.x = mouse.x
        //             messageMenuMine.y = mouse.y + 10
        //             messageMenuMine.open()
        //         } else {
        //             messageMenuOther.x = mouse.x
        //             messageMenuOther.y = mouse.y + 10
        //             messageMenuOther.open()
        //         }
        //     }
        // }
        onClicked: (event) => {  // Declare "event" explicitly
            if (event.button === Qt.RightButton) {
                if (is_Mine) {
                    messageMenuMine.x = event.x
                    messageMenuMine.y = event.y + 10
                    messageMenuMine.open()
                } else {
                    messageMenuOther.x = event.x
                    messageMenuOther.y = event.y + 10
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
                    // console.log("Edit message: " + messageContent)
                    bridge.menu_edith_msg(messageContent)
                    bridge.menu_edith_msg_index(messageIndex)
                    bridge.menu_edith_msg_time(messageTimeStamp)
                }
            }
            MenuItem {
                text: qsTr("Copy")
                onTriggered: {
                    // console.log("Copy message: " + messageContent)
                    bridge.menu_copy_msg(messageContent)
                }
            }
            MenuItem {
                text: qsTr("Delete")
                onTriggered: {
                    // console.log("Delete message: " + messageContent)
                    // bridge.menu_delete_msg(messageContent)
                    bridge.menu_delete_msg(messageIndex)
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

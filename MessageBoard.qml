import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

GroupBox {
    title: "Chatroom"
    Layout.fillHeight: true
    Layout.preferredWidth: parent.width
    property alias model: chatListView.model

    ListView {
        id: chatListView
        anchors.fill: parent
        model: []
        // model: bridge.pyside_chat_list

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
                text: "10"
                color: "lightgrey"
                anchors.right: isMine ? parent.right : undefined
                anchors.left: !isMine ? parent.left : undefined
                font.pixelSize: 10
            }
        }
    }
}
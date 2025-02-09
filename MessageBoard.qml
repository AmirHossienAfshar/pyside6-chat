import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

GroupBox {
    title: "Chatroom"
    Layout.fillHeight: true
    Layout.preferredWidth: parent.width
    property alias model: chatListView.model

    ScrollView {
        id: chatScrollView
        anchors.fill: parent
        spacing: 10

        ListView {
            id: chatListView
            width: chatScrollView.width
            height: chatScrollView.height
            model: []

            delegate: Column {
                property var parts: modelData.split("#")

                property string sender: parts.length > 0 ? parts[0] : "ERROR"
                property string timestamp: parts.length > 1 ? parts[2] : "00:00"
                property string messageContent: parts.length > 2 ? parts[3] : "Parsing Error"

                property bool isMine: sender === "THIS"

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
                            text: messageContent
                            color: isMine ? "black" : "white"
                            anchors.fill: parent
                            anchors.margins: 12
                            wrapMode: Label.Wrap
                        }
                        MessageMenu {
                            is_Mine: isMine
                            // messageContent: messageContent
                            messageContent: messageText.text
                        }
                    }
                }

                Label {
                    id: timestampText
                    text: timestamp
                    color: "lightgrey"
                    anchors.right: isMine ? parent.right : undefined
                    anchors.left: !isMine ? parent.left : undefined
                    font.pixelSize: 10
                }
            }

            Component.onCompleted: {
                chatListView.positionViewAtIndex(chatListView.count - 1, ListView.End)
            }

            onCountChanged: {
                chatListView.positionViewAtIndex(chatListView.count - 1, ListView.End)
            }
        }
    }
}

// import QtQuick 6.5
// import QtQuick.Controls 6.5
// import QtQuick.Layouts

// GroupBox {
//     title: "Chatroom"
//     Layout.fillHeight: true
//     Layout.preferredWidth: parent.width
//     property alias model: chatListView.model

//     ListView {
//         id: chatListView
//         anchors.fill: parent
//         model: []

//         delegate: Column {
//             property bool isMine: modelData.startsWith("mine: ")

//             anchors.right: isMine ? chatListView.contentItem.right : undefined
//             anchors.left: !isMine ? chatListView.contentItem.left : undefined
//             spacing: 6

//             Row {
//                 id: messageRow
//                 spacing: 6
//                 anchors.right: isMine ? parent.right : undefined
//                 anchors.left: !isMine ? parent.left : undefined

//                 Rectangle {
//                     width: Math.min(messageText.implicitWidth + 24, chatListView.width - 40)
//                     height: messageText.implicitHeight + 24
//                     radius: 15
//                     color: isMine ? "lightgrey" : "steelblue"

//                     Label {
//                         id: messageText
//                         text: modelData.substring(modelData.indexOf(": ") + 2)
//                         color: isMine ? "black" : "white"
//                         anchors.fill: parent
//                         anchors.margins: 12
//                         wrapMode: Label.Wrap
//                     }
//                 }
//             }

//             Label {
//                 id: timestampText
//                 text: "10"
//                 color: "lightgrey"
//                 anchors.right: isMine ? parent.right : undefined
//                 anchors.left: !isMine ? parent.left : undefined
//                 font.pixelSize: 10
//             }
//         }
//     }
// }

// import QtQuick 6.5
// import QtQuick.Controls 6.5
// import QtQuick.Layouts

// GroupBox {
//     title: "Chatroom"
//     Layout.fillHeight: true
//     Layout.preferredWidth: parent.width
//     property alias model: chatListView.model

//     ListView {
//         id: chatListView
//         anchors.fill: parent
//         model: []
        
//         delegate: Column {
//             width: chatListView.width
//             spacing: 6

//             // Extract timestamp
//             property string timestamp: modelData.substring(modelData.indexOf("time:") + 5, modelData.indexOf(","))
//             property string messageContent: modelData.substring(modelData.indexOf(": ") + 2)
//             property bool isMine: messageContent.startsWith("mine: ")

//             // Ensure correct alignment of messages
//             anchors.right: isMine ? chatListView.contentItem.right : undefined
//             anchors.left: !isMine ? chatListView.contentItem.left : undefined

//             Row {
//                 id: messageRow
//                 spacing: 6
//                 anchors.right: isMine ? parent.right : undefined
//                 anchors.left: !isMine ? parent.left : undefined

//                 Rectangle {
//                     width: Math.min(messageText.implicitWidth + 24, chatListView.width - 40)
//                     height: messageText.implicitHeight + 24
//                     radius: 15
//                     color: isMine ? "lightgrey" : "steelblue"

//                     Label {
//                         id: messageText
//                         text: messageContent.substring(messageContent.indexOf(": ") + 2)  // Extract only message
//                         color: isMine ? "black" : "white"
//                         anchors.fill: parent
//                         anchors.margins: 12
//                         wrapMode: Label.Wrap
//                     }
//                 }
//             }

//             Label {
//                 id: timestampText
//                 text: timestamp
//                 color: "lightgrey"
//                 anchors.right: isMine ? parent.right : undefined
//                 anchors.left: !isMine ? parent.left : undefined
//                 font.pixelSize: 10
//             }
//         }
//     }
// }
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
        model: []  // model will be provided externally

        delegate: Column {
            width: chatListView.width
            spacing: 6

            // 1. Find the first delimiter ", "
            property int delimIndex: modelData.indexOf(", ")
            // 2. Extract the time part, e.g. "time:08:27"
            property string timePart: modelData.substring(0, delimIndex)
            // 3. Extract the rest (sender and message), e.g. "mine: Hey, how are you?"
            property string restPart: modelData.substring(delimIndex + 2)
            // 4. The timestamp is everything after "time:" in timePart.
            property string timestamp: timePart.substring(5)
            // 5. Determine whether it’s "mine" by checking if restPart starts with "mine:"
            property bool isMine: restPart.startsWith("mine:")
            // 6. Extract the message text by finding the first occurrence of ": " in restPart.
            property int colonIndex: restPart.indexOf(": ")
            property string messageContent: restPart.substring(colonIndex + 2)

            Row {
                id: messageRow
                spacing: 6
                // Align the row based on the sender
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
    }
}

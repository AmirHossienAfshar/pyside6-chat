import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

GroupBox {
    id: mainGroupBox
    title: "contacts"
    property alias model: contactsListView.model

    ScrollView {
        id: chatScrollView
        anchors.fill: parent
        spacing: 10

        ListView {
            id: contactsListView
            width: contactScrollView.width
            height: chatScrollView.height
            // model: []
            model: ListModel {
                ListElement { name: "Alice" }
                ListElement { name: "Bob" }
                ListElement { name: "Charlie" }
            }
            delegate: Item {
                width: contactsListView.width
                height: 50  // Height for each contact button
                Button {
                    id: contactButton
                    text: model.name
                    width: parent.width
                    height: parent.height
                    onClicked: {
                        console.log("Clicked on:", model.name);
                        // Call your function here when the button is clicked
                    }
                }
            }
            Component.onCompleted: {
                contactsListView.positionViewAtIndex(contactsListView.count - 1, ListView.End)
            }
            onCountChanged: {
                contactsListView.positionViewAtIndex(contactsListView.count - 1, ListView.End)
            }
        }
    }
}

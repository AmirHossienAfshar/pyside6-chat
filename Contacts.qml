import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

GroupBox {
    id: mainGroupBox
    title: "contacts"
    property alias contactModel: contactsListView.model

    ScrollView {
        id: chatScrollView
        anchors.fill: parent
        spacing: 10

        ListView {
            id: contactsListView
            // width: contactScrollView.width
            width: chatScrollView.width
            height: chatScrollView.height
            model: []
            delegate: Item {
                width: contactsListView.width
                height: 50  // Height for each contact button
                Button {
                    id: contactButton
                    text: modelData
                    width: parent.width
                    height: parent.height
                    onClicked: {
                        console.log("Clicked on:", modelData);
                        // Call your function here when the button is clicked
                        // console.log("model is:", model)
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

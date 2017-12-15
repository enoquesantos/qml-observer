import QtQuick 2.9
import QtQuick.Controls 2.2

import Observer 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Observer {
        id: observer
        events: ["ItemReady"]
        objectName: "observerItem"
        onUpdated: console.log("observer notify from event: ", events[0])

        Component.onCompleted: Subject.attach(observer, observer.events)
    }

    MyItem {
    }

    Item {
        id: item
    }

    Column {
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            width: 200; height: 50
        }

        Label {
            text: "Enter the event name"
        }

        TextField {
            id: textField
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: button
            text: "Notificar"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: Subject.notify(textField.text, {"id": "1"}, button)
        }
    }
}

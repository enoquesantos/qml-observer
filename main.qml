import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2

import Observer 1.0

ApplicationWindow {
    visible: true
    width: Qt.platform.os === "linux" || Qt.platform.os === "osx" ? (Screen.width / 2.5) : Screen.width
    height: Qt.platform.os === "linux" || Qt.platform.os === "osx" ? (Screen.height * 0.90) : Screen.height
    title: qsTr("Hello World!")

    Component.onCompleted: {
        // when runnig in desktop mode, centralize the application window.
        if (["linux","osx"].indexOf(Qt.platform.os) > -1) {
            setX(Screen.width / 2 - width / 2)
            setY(Screen.height / 2 - height / 2)
        }
    }

    Observer {
        id: observer
        events: ["ItemReady"]
        objectName: "observerItem"
        onUpdated: console.log("observer notify from event: ", events[0])

        Component.onCompleted: Subject.attach(observer, observer.events)
    }

    MyItem { }

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

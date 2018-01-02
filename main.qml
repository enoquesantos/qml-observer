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

    QtObject {
        id: qtobject
        property var eventsList: ["event_1", "event_2", "event_3", "event_4", "event_5"]
    }

    Observer {
        id: observer
        events: qtobject.eventsList[0]
        objectName: "observerItem"
        onUpdated: console.log("observer notify from event: ", events[0])

        Component.onCompleted: Subject.attach(observer, observer.events)
    }

    MyItem { objectName: "MyItem.1"; eventsList: qtobject.eventsList[0] }
    MyItem { objectName: "MyItem.2"; eventsList: qtobject.eventsList[0] }
    MyItem { objectName: "MyItem.3"; eventsList: qtobject.eventsList[1] }
    MyItem { objectName: "MyItem.4"; eventsList: qtobject.eventsList[1] }
    MyItem { objectName: "MyItem.5"; eventsList: qtobject.eventsList[2] }
    MyItem { objectName: "MyItem.6"; eventsList: qtobject.eventsList[2] }
    MyItem { objectName: "MyItem.7"; eventsList: qtobject.eventsList[3] }
    MyItem { objectName: "MyItem.8"; eventsList: qtobject.eventsList[3] }
    MyItem { objectName: "MyItem.9"; eventsList: qtobject.eventsList[4] }
    MyItem { objectName: "MyItem.10"; eventsList: qtobject.eventsList[4] }

    Column {
        spacing: 15
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            width: parent.width; height: 50
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18
            text: qsTr("Select a event to notify observers")
        }

        ComboBox {
            id: comboBox
            currentIndex: -1
            model: qtobject.eventsList
            width: parent.width * 0.80; height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            onActivated: Subject.notify(comboBox.currentText, {"id": "1"}, comboBox)
        }
    }
}

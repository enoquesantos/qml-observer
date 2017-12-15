import QtQuick 2.8

import Observer 1.0

Item {
    id: newObserver

    Component.onCompleted: Subject.attach(observer, observer.events)

    Observer {
        id: observer
        events: ["newEventObserver"]
        objectName: "newObserverItem"
        onUpdated: console.log("newObserverItem notify from event: ", events[0])
    }
}

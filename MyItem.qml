import QtQuick 2.8

import Observer 1.0

Item {
    id: item
    property var eventsList: []

    Observer {
        id: observer
        events: eventsList
        objectName: "newObserverItem"
        onUpdated: console.log("%1 notify from event: %2".arg(item.objectName).arg(events[0]))
        onEventsChanged: if (observer.events) Subject.attach(observer, observer.events)
    }
}

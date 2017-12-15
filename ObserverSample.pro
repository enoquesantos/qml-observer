QT += quick quickcontrols2

CONFIG += c++11

HEADERS += observer.h subject.h

SOURCES += main.cpp observer.cpp subject.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

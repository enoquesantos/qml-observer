#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "subject.h"
#include "observer.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<Observer>("Observer", 1, 0, "Observer");

    Subject subject(&app);
    engine.rootContext()->setContextProperty(QStringLiteral("Subject"), &subject);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

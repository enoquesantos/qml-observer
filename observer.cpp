#include "observer.h"
#include "subject.h"

#ifdef QT_DEBUG
#include <QDebug>
#include <QThread>
#endif

Observer::Observer(QObject *parent) : QObject(parent)
{
}

Observer::~Observer()
{
    if (m_subject && m_events.size()) {
        foreach (const QString &event, m_events) {
            #ifdef QT_DEBUG
                qDebug() << "detaching from event: " << event;
            #endif
            m_subject->dettach(this, event);
        }
    }
}

QStringList Observer::events()
{
    return m_events;
}

void Observer::setSubject(Subject *subject)
{
    m_subject = subject;
}

void Observer::setEvents(const QStringList &events)
{
    m_events = events;
    emit eventsChanged(m_events);
    #ifdef QT_DEBUG
        qDebug() << "observer assign event: " << events;
    #endif
}

void Observer::update(const QString &eventName, const QVariant &args, QQuickItem *sender)
{
    #ifdef QT_DEBUG
        qDebug() << "observer updated in thread id: " << QThread::currentThread();
    #endif
    emit updated(eventName, args, sender);
}

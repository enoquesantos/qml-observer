#ifndef SUBJECT_H
#define SUBJECT_H

#include <QDebug>
#include <QMap>
#include <QObject>
#include <QQuickItem>
#include <QThread>
#include <QVector>

#include "observer.h"

namespace Private {
class Worker : public QThread
{
    Q_OBJECT
public:
    Worker(Observer *o, const QString &event, const QVariant &args, QQuickItem *sender, QObject *parent = nullptr) : QThread(parent)
    {
        this->observer = o;
        this->event = event;
        this->args = args;
        this->sender = sender;
    }

private:
    Observer *observer;
    QString event;
    QVariant args;
    QQuickItem *sender;

protected:
    void run() override
    {
        // qDebug() << "notify observer in thread: " << QThread::currentThread();
        this->observer->update(this->event, this->args, this->sender);
    }
};
}

class Subject : public QObject
{
    Q_OBJECT
public:
    explicit Subject(QObject *parent = Q_NULLPTR);
    ~Subject();

    Q_INVOKABLE
    void attach(Observer *observer, const QString &event);

    Q_INVOKABLE
    void attach(Observer *observer, const QVariantList &events);

    Q_INVOKABLE
    void dettach(Observer *observer, const QString &event);

    Q_INVOKABLE
    void notify(const QString &event, const QVariant &args, QQuickItem *sender);

private:
    QMap<QString, QVector<Observer*>> m_attacheds;
};

#endif // SUBJECT_H

#ifndef BACKLIGHT_H
#define BACKLIGHT_H

#include <QObject>
#include <QProcess>
#include <QDebug>

class BackLight : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(int value READ getBacklight)
public:
    explicit BackLight(QObject *parent = nullptr);

signals:

public slots:
    Q_INVOKABLE void setBacklight(QString value);
    Q_INVOKABLE void shutdown();
    Q_INVOKABLE void reboot();
    //int getBacklight();
private:
    QProcess *cmd;
    QString cmd_str, m_output;
};

#endif // BACKLIGHT_H

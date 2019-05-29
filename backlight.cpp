#include "backlight.h"

BackLight::BackLight(QObject *parent) : QObject(parent)
{
    cmd = new QProcess(this);
    /*cmd->setReadChannelMode(QProcess::MergedChannels);
    cmd->start("cat /home/enoriel/testbl.txt");
    cmd_str = "cat /home/enoriel/testbl.txt";
    m_output = cmd->readAllStandardOutput();
    cmd->close();*/
    m_output = "100";
}

void BackLight::setBacklight(QString value)
{
    cmd->start("sh");
    cmd_str = "echo "+value+" > /home/enoriel/testbl.txt";
    cmd->write(cmd_str.toUtf8());
    cmd->closeWriteChannel();
    cmd->waitForFinished();
    QByteArray output = cmd->readAll();
    cmd->close();
}

void BackLight::shutdown()
{
    cmd->start("shutdown now");
    cmd->waitForFinished();
    QByteArray output = cmd->readAll();
    cmd->close();
    qDebug() << output << endl;
}

void BackLight::reboot()
{
    cmd->start("reboot");
    cmd->waitForFinished();
    QByteArray output = cmd->readAll();
    cmd->close();
    qDebug() << output << endl;
}
